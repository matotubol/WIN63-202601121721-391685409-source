package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HeightMapUpdateMessageEventParser implements IMessageParser
   {
      
      private var var_24:IMessageDataWrapper;
      
      private var _count:int;
      
      private var var_25:int;
      
      private var var_26:int;
      
      private var _value:int;
      
      private var var_3465:int = 16384;
      
      private var var_4366:int = 16383;
      
      public function HeightMapUpdateMessageEventParser()
      {
         super();
      }
      
      public function set stackingBlockedMaskBit(param1:int) : void
      {
         var_3465 = 1 << param1;
         var_4366 = var_3465 - 1;
      }
      
      public function next() : Boolean
      {
         if(_count == 0)
         {
            return false;
         }
         _count = _count - 1;
         var_25 = var_24.readByte();
         var_26 = var_24.readByte();
         _value = var_24.readShort();
         return true;
      }
      
      public function get x() : int
      {
         return var_25;
      }
      
      public function get y() : int
      {
         return var_26;
      }
      
      public function get tileHeight() : Number
      {
         return HeightMapMessageEventParser.decodeTileHeight(_value,var_4366);
      }
      
      public function get isStackingBlocked() : Boolean
      {
         return HeightMapMessageEventParser.decodeIsStackingBlocked(_value,var_3465);
      }
      
      public function get isRoomTile() : Boolean
      {
         return HeightMapMessageEventParser.decodeIsRoomTile(_value);
      }
      
      public function flush() : Boolean
      {
         _count = 0;
         var_24 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_24 = param1;
         _count = param1.readByte();
         return true;
      }
   }
}

