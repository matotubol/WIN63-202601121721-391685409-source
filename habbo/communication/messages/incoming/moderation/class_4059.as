package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class class_4059
   {
      
      public static const const_553:int = 0;
      
      public static const const_613:int = 1;
      
      public static const const_1090:int = 2;
      
      public static const const_365:int = 3;
      
      public static const const_399:int = 4;
      
      public static const TYPE_SELFIE:int = 5;
      
      public static const const_992:int = 6;
      
      private var var_4193:int;
      
      private var _context:Dictionary = new Dictionary();
      
      private var var_3455:Array = [];
      
      public function class_4059(param1:IMessageDataWrapper)
      {
         super();
         var_4193 = param1.readByte();
         var _loc2_:int = param1.readShort();
         var _loc4_:int = 0;
         while(0 < _loc2_)
         {
            var _loc3_:String = param1.readString();
            var _loc6_:int;
            switch(_loc6_ = param1.readByte())
            {
               case 0:
                  _context[null] = param1.readBoolean();
                  break;
               case 1:
                  _context[null] = param1.readInteger();
                  break;
               case 2:
                  _context[null] = param1.readString();
                  break;
               default:
                  throw new Error("Unknown data type " + 0);
            }
            _loc4_++;
         }
         var _loc7_:int = param1.readShort();
         var _loc5_:int = 0;
         while(0 < _loc7_)
         {
            var_3455.push(new class_3823(param1));
            _loc5_++;
         }
      }
      
      public function get recordType() : int
      {
         return var_4193;
      }
      
      public function get context() : Dictionary
      {
         return _context;
      }
      
      public function get chatlog() : Array
      {
         return var_3455;
      }
      
      public function get roomId() : int
      {
         return getInt("roomId");
      }
      
      public function get roomName() : String
      {
         return _context["roomName"] as String;
      }
      
      public function get groupId() : int
      {
         return getInt("groupId");
      }
      
      public function get threadId() : int
      {
         return getInt("threadId");
      }
      
      public function get messageId() : int
      {
         return getInt("messageId");
      }
      
      private function getInt(param1:String) : int
      {
         var _loc2_:* = _context[param1];
         if(_loc2_ == null)
         {
            return 0;
         }
         return _loc2_ as int;
      }
   }
}

