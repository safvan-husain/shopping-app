import { Request, Response, Router } from "express";
const { model, default: mongoose } = require("mongoose");
import { User } from "../model/user";
import { auth } from "../middlewares/auth";
import { Product } from "../model/product";

const router = Router();

router.get("/get-all-product", auth, async (req: Request, res: Response) => {
  try {
    const products = await Product.find();
    res.status(200).json(products);
  } catch (error: any) {
    res.status(500).json({ msg: error.message });
  }
});

router.get(
  "/get-ordered-products",
  auth,
  async (req: Request, res: Response) => {
    try {
      // const products = await Product.find();
      res.status(200).json([]);
    } catch (error: any) {
      res.status(500).json({ msg: error.message });
    }
  }
);

router.post("/add-to-cart/:id", auth, async (req: Request, res: Response) => {
  let { id } = req.params;
  let { quantity }: any = req.query;

  quantity = parseInt(quantity);
  try {
    var user = await User.findById(req.userId);

    var productId = mongoose.Types.ObjectId(id);
    var product = await Product.findById(productId);
    var isthereProduct = false;
    if (user != null && user.cart) {
      if (user.cart.length == 0) {
        var cartItem = {
          product: product,
          quantity: quantity,
        };
        user.cart.push(cartItem);
      } else {
        for (let i = 0; i < user.cart.length; i++) {
          if (user.cart[i].product._id.equals(productId)) {
            user.cart[i].quantity += quantity;
            isthereProduct = true;
            break;
          }
        }
        if (!isthereProduct) {
          var cartItem = {
            product: product,
            quantity: quantity,
          };
          user.cart.push(cartItem);
        }
      }
      // user.cart = [];
      user = await user.save();
      res.status(200).json(user);
    }
  } catch (error: any) {
    console.log(error);
    res.status(500).json({ msg: error.message });
  }
});
router.get(
  "/remove-item-cart/:id",
  auth,
  async (req: Request, res: Response) => {
    let { id } = req.params;
    try {
      var productId = mongoose.Types.ObjectId(id);
      var user = await User.findById(req.userId);
      if (user != null && user.cart) {
        for (let i = 0; i < user.cart.length; i++) {
          if (user.cart[i].product._id.equals(productId)) {
            if (user.cart[i].quantity == 1) {
              user.cart.splice(i, 1);
            } else {
              user.cart[i].quantity--;
            }
            break;
          }
        }
        user = await user.save();
        res.status(200).json(user);
      }
    } catch (error: any) {
      console.log(error);
      res.status(500).json({ msg: error.message });
    }
  }
);


router.delete("/delete-cart", auth, async (req: Request, res: Response) => {
  try {
    var user = await User.findById(req.userId);
    if (user?.cart) {
      user.cart = [];
      user = await user.save();
    }
    res.status(200).json(user);
  } catch (error: any) {
    res.status(500).json({ msg: error.message });
  }
});

export { router as productRouter };
