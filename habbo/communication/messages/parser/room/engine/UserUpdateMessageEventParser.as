package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_3159;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_3587;
   
   [SecureSWF(rename="true")]
   public class UserUpdateMessageEventParser implements IMessageParser
   {
      
      private var _users:Array = [];
      
      public function UserUpdateMessageEventParser()
      {
         super();
      }
      
      public function get userUpdateCount() : int
      {
         return _users.length;
      }
      
      public function flush() : Boolean
      {
         _users = [];
         return true;
      }
      
      public function getUserUpdateData(param1:int) : class_3587
      {
         if(param1 < 0 || param1 >= userUpdateCount)
         {
            return null;
         }
         return _users[param1];
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc22_:int = 0;
         var _loc15_:int = 0;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc2_:int = 0;
         var _loc25_:int = 0;
         var _loc9_:String = null;
         var _loc10_:* = false;
         var _loc16_:int = 0;
         var _loc7_:int = 0;
         var _loc30_:Array = null;
         var _loc20_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc11_:Boolean = false;
         var _loc12_:Array = null;
         var _loc8_:Boolean = false;
         var _loc23_:int = 0;
         var _loc5_:String = null;
         var _loc14_:Array = null;
         var _loc26_:String = null;
         var _loc17_:String = null;
         var _loc3_:Array = null;
         var _loc24_:Number = NaN;
         var _loc6_:Number = NaN;
         if(param1 == null)
         {
            return false;
         }
         var _loc21_:int = param1.readInteger();
         _loc22_ = 0;
         while(_loc22_ < _loc21_)
         {
            _loc15_ = param1.readInteger();
            _loc27_ = param1.readInteger();
            _loc28_ = param1.readInteger();
            _loc29_ = Number(param1.readString());
            _loc13_ = 0;
            _loc2_ = param1.readInteger();
            _loc25_ = param1.readInteger();
            _loc9_ = param1.readString();
            _loc10_ = false;
            _loc16_ = _loc2_ % 8 * 45;
            _loc7_ = _loc25_ % 8 * 45;
            _loc30_ = [];
            _loc20_ = 0;
            _loc19_ = 0;
            _loc18_ = 0;
            _loc11_ = false;
            _loc12_ = _loc9_.split("/");
            _loc8_ = false;
            _loc23_ = 0;
            while(_loc23_ < _loc12_.length)
            {
               _loc5_ = _loc12_[_loc23_] as String;
               _loc14_ = _loc5_.split(" ");
               _loc26_ = String(_loc14_[0]);
               _loc17_ = "";
               if(_loc26_ != "")
               {
                  if(_loc26_ == "wf")
                  {
                     _loc8_ = true;
                  }
                  if(_loc14_.length >= 2)
                  {
                     _loc17_ = String(_loc14_[1]);
                     switch(_loc26_)
                     {
                        case "mv":
                           _loc3_ = _loc17_.split(",");
                           if(_loc3_.length >= 3)
                           {
                              _loc20_ = int(_loc3_[0]);
                              _loc19_ = int(_loc3_[1]);
                              _loc18_ = Number(_loc3_[2]);
                              _loc11_ = true;
                           }
                           break;
                        case "sit":
                           _loc24_ = Number(_loc17_);
                           if(_loc14_.length >= 3)
                           {
                              _loc10_ = _loc14_[2] == "1";
                           }
                           _loc13_ = _loc24_;
                           break;
                        case "lay":
                           _loc6_ = Number(_loc17_);
                           if(_loc6_ < 0)
                           {
                           }
                           _loc13_ = Math.abs(_loc6_);
                     }
                  }
                  _loc30_.push(new class_3159(_loc26_,_loc17_));
               }
               _loc23_++;
            }
            var _loc4_:class_3587 = new class_3587(_loc15_,_loc27_,_loc28_,_loc29_,_loc13_,_loc7_,_loc16_,_loc20_,_loc19_,_loc18_,_loc11_,_loc10_,_loc30_,_loc8_);
            _users.push(null);
            _loc22_++;
         }
         return true;
      }
   }
}

