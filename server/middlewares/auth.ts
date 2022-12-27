
import {Request, Response ,NextFunction} from 'express'
import { Jwt } from '../utils/Authentication_token';

//verifying wether  token valid or not
export const auth = async (req:Request, res:Response, next:NextFunction) => {
    const token = req.header('x-auth-token');
    if(token) {
        const validate = await Jwt.verifyToken(token)
        if(validate) {
            //userId from token 
            req.userId = validate.id;            
            next()
        } else {
            res.status(400).json({msg: 'token is not valid!'})
        }              
    } else {
        res.status(400).json({msg : 'token is not find!'}) 
    }           
}
