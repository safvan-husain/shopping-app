import { Schema, Document,model } from 'mongoose'

 interface Iproduct extends Document{
  name: String,
  price: Number,
  images: Array<String>,
  category: String
}

const productSchema =new Schema({
  name: {
    required: true,
    type: String,
  },
  price: {
    required: true,
    type: Number,
  },
  images: [
    {
      required: true,
      type: String,
    },
  ],
  category: {
    required: true,
    type: String,
  },
});

const Product = model<Iproduct>("Product", productSchema);

export  {Product,productSchema};
