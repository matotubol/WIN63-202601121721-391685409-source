package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3702
   {
      
      private var var_1270:int;
      
      private var _userName:String;
      
      private var _rooms:Array = [];
      
      public function class_3702(param1:IMessageDataWrapper)
      {
         super();
         var_1270 = param1.readInteger();
         _userName = param1.readString();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            _rooms.push(new class_4059(param1));
            _loc3_++;
         }
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get rooms() : Array
      {
         return _rooms;
      }
   }
}

