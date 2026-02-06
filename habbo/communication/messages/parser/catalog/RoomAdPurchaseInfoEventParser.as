package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.class_2794;
   
   [SecureSWF(rename="true")]
   public class RoomAdPurchaseInfoEventParser implements IMessageParser
   {
      
      private var var_3598:Boolean;
      
      private var _rooms:Array;
      
      public function RoomAdPurchaseInfoEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function get rooms() : Array
      {
         return _rooms;
      }
      
      public function get isVip() : Boolean
      {
         return var_3598;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _rooms = [];
         var_3598 = param1.readBoolean();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var _loc5_:int = param1.readInteger();
            var _loc6_:String = param1.readString();
            var _loc4_:Boolean = param1.readBoolean();
            var _loc7_:class_2794 = new class_2794(0,null,false);
            _rooms.push(null);
            _loc3_++;
         }
         return true;
      }
   }
}

