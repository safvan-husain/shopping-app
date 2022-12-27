import {Request, Response, Router} from 'express'
import mongoose from 'mongoose'
import { auth } from '../middlewares/auth';
import { Product } from '../model/product';
import { User } from '../model/user'
const router = Router();

router.put("/add-to-favourite/:id", auth, async (req:Request, res:Response) => {
  let { id }:any = req.params;
  id = new mongoose.Types.ObjectId(id);
  try {
    let product = await Product.findById(id);
    let user = await User.findById(req.userId);
    // user = user[0];
    if(user != null && user.favourites != undefined) {
      let isthereProduct = false;
      if (user.favourites.length == 0) {
        user.favourites.push(product);
      } else {
        for (let i = 0; i < user.favourites.length; i++) {
          if (user.favourites[i]._id.equals(id)) {
            user.favourites.splice(i, 1);
            isthereProduct = true;
            break;
          }
        }
        if (!isthereProduct) {
          user.favourites.push(product);
        }
      }
      user = await user.save();
      res.status(200).json(user);}
    
  } catch (error:any) {
    res.status(500).json({ error: error.message });
  }
});

router.get("/get-fav-products", auth, async (req:Request, res:Response) => {
  try {
    let user = await User.findById(req.userId);
    var products = user?.favourites;
    res.status(200).json(products);
  } catch (error:any) {
    res.status(500).json({ error: error.message });
  }
});

router.get("/get-cart", auth, async (req:Request, res:Response) => {
  try {
    var user = await User.findById(req.userId);
    if(user!=null)
    res.status(200).json(user.cart);
  } catch (error:any) {
    res.status(500).json({ msg: error.message });
  }
});

router.post("/edit-name", auth, async (req, res) => {
  const { name } = req.body;
  console.log(name);
  try {
    var user = await User.findByIdAndUpdate({ _id:req.userId},{name:name});
   
    console.log(user);
    res.status(200).json(user);
  } catch (error:any) {
    console.log(error);
    res.status(500).json({ error: error.message });
  }
});
router.post("/update-avatar", auth, async (req:Request, res:Response) => {
  const { avatar } = req.body;
  console.log(avatar);
  try {
    var user = await User.findByIdAndUpdate({ _id:req.userId},{avatar:avatar});
    
    console.log(user);
    res.status(200).json(user);
  } catch (error:any) {
    console.log(error);
    res.status(500).json({ error: error.message });
  }
});

export { router as userRouter }
