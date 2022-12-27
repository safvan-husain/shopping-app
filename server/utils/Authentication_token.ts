import jwt from 'jsonwebtoken'; 
import { ObjectId } from 'mongoose';

export class Jwt {
    //generate token
    static async generateToken(id: ObjectId) : Promise<string> {       
        return await jwt.sign({"id":id},'privet-key')
    }
    static async verifyToken(token : string) : Promise<any> { 
        try {           
            return await jwt.verify(token,'privet-key')
        } catch (error) {
            //if token verfication failed 
            return null;
        }      
    }
}