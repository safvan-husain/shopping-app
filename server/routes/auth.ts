import { Router, Express, Request, Response } from "express";
import { User } from "../model/user";
import { Jwt } from "../utils/Authentication_token";
import { auth } from "../middlewares/auth";
import { Password } from "../utils/password";
const router = Router();



//user data from authentication-token
router.get("/auth", auth, async (req: Request, res: Response) => {
  //userId from auth middleware
  const user = await User.findById(req.userId)
  if(!user){
    res.status(400).json({msg: 'user not found!'})
  } else {
    res.status(200).json(user);
  } 
});

router.post("/auth/sign-up", async (req: Request, res: Response) => {
  const { name, email, password, avatar } = req.body;

  const hashedPassword = await Password.hashPassword(password);

  let user = await User.findOne({ email });
  if (user != null) {    
    res.status(400).json({ msg: `user with ${email} already exist` });
  } else {
    user = new User({
      name,
      email,
      password: hashedPassword,
      avatar,
    });
    user = await user.save();
    const token = await Jwt.generateToken(user._id);
    res.status(200).json({ user: user, token: token });
  }
});

router.post("/auth/google-sign-in", async (req: Request, res: Response) => {
  const { email } = req.body;
  
  try {
    let user = await User.findOne({ email });
    if (user != null) {
      const token = await Jwt.generateToken(user._id)
      res.status(200).json({"user": user, "token": token});
    } else {
      res.status(400).json({ msg: `No user found with ${email}` });
    }
  } catch (error: any) {
    console.log(error);
    res.status(500).json({ error: error.message });
  }
});
router.post("/auth/sign-in", async (req: Request, res: Response) => {
  const { email, password } = req.body;
 
  try {
    let user = await User.findOne({ email });
    if (user != null) {
      var isPassordCorrect = await Password.comparePasswords(password,user.password as string)
      if (isPassordCorrect) {
        const token = await Jwt.generateToken(user._id)
        res.status(200).json({"user": user, "token": token});
      } else {
        res.status(400).json({ msg: "Password is incorrect!" });
      }
    } else {
      res.status(400).json({ msg: `No user found with ${email}` });
    }
  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
});


export { router as authRouter }
