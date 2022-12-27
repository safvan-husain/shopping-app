import  express,{Express,Request,Response} from'express';
import mongoose from 'mongoose'
import bodyParser  from 'body-parser';
import { authRouter } from './routes/auth';
import { userRouter } from './routes/users';
import { productRouter } from './routes/product';
import { adminRouter } from './routes/admin';
require('dotenv').config();
const app:Express = express();


//DataBase connection
const DB = process.env.DataBase;
mongoose.connect(DB!).then(() => {
    console.log('connected to database'); 
}).catch((e:any) => {
    console.log(e);
})
//middlewares
app.use(bodyParser.json());
app.use(authRouter);
app.use(productRouter);
app.use(userRouter);  
app.use(adminRouter)

app.get('/',(req:Request, res:Response) => {
    res.send('home')
})
app.get('/privacy-policy',(req:Request, res:Response) => {
    res.send('/privacy-policy   - only for test purpouse')
})
app.get('/terms-of-services',(req:Request, res:Response) => {
    res.send('/terms-of-services   - only for test purpouse')
})
//server 
app.listen(3000,() => {
    console.log('server started on 3000');
})