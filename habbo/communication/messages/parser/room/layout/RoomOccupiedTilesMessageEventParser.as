package com.sulake.habbo.communication.messages.parser.room.layout
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomOccupiedTilesMessageEventParser implements IMessageParser
   {
      
      private var var_3613:Array;
      
      public function RoomOccupiedTilesMessageEventParser()
      {
         super();
      }
      
      public function get occupiedTiles() : Array
      {
         return var_3613;
      }
      
      public function flush() : Boolean
      {
         var_3613 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInteger();
            _loc5_ = param1.readInteger();
            var_3613.push({
               "x":_loc4_,
               "y":_loc5_
            });
            _loc3_++;
         }
         return true;
      }
   }
}

