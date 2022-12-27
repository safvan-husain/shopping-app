import { Document, Schema,model } from "mongoose";
import { productSchema } from '../model/product'

interface UserDoc extends Document {
  name: String;
  email: String;
  password: String;
  type: String;
  avatar?: String;
  favourites?: Array<any>;
  cart?: Array<any>;
}

const userSchema = new Schema({
  name: {
    required: true,
    type: String,
  },
  email: {
    required: true,
    type: String,
  },
  password: {
    required: true,
    type: String,
  },
  avatar: {
    type: String,
  },
  type: {
    type: String,
    default: "user",
  },
  favourites: [productSchema],
  cart: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
});

const User = model<UserDoc>("User", userSchema);
export  { User };
