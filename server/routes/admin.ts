import { Request, Response, Router } from "express";
import mongoose from "mongoose";
import { auth } from "../middlewares/auth";
import { Product } from '../model/product'
const router = Router();

router.post("/add-product", auth, async (req: Request, res: Response) => {
    const { name, price, images, category } = req.body;
    let product = new Product({
      name,
      price,
      images,
      category,
    });
    try {
      product = await product.save();
      res.status(200).json(product);
    } catch (error: any) {
      res.status(500).json({ error: error.message });
    }
  });

  router.delete("/delete-product/:id", auth, async (req:Request, res:Response) => {
    let { id }:any = req.params;
    id = new mongoose.Types.ObjectId(id);
  
    await Product.deleteOne({ _id: id });
  });

  export { router as adminRouter }