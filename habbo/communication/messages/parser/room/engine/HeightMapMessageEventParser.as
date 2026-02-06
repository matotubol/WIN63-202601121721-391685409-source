package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HeightMapMessageEventParser implements IMessageParser
   {
      
      private var var_3465:int = 16384;
      
      private var var_4366:int = 16383;
      
      private var var_24:Vector.<int>;
      
      private var _width:int = 0;
      
      private var var_385:int = 0;
      
      public function HeightMapMessageEventParser()
      {
         super();
      }
      
      public static function decodeTileHeight(param1:int, param2:int) : Number
      {
         return param1 == -1 ? -1 : (param1 & param2) / 256;
      }
      
      public static function decodeIsStackingBlocked(param1:int, param2:int) : Boolean
      {
         return Boolean(param1 & param2);
      }
      
      public static function decodeIsRoomTile(param1:int) : Boolean
      {
         return param1 != -1;
      }
      
      public function decodeTileHeight(param1:int) : Number
      {
         return HeightMapMessageEventParser.decodeTileHeight(param1,var_4366);
      }
      
      public function decodeIsStackingBlocked(param1:int) : Boolean
      {
         return HeightMapMessageEventParser.decodeIsStackingBlocked(param1,var_3465);
      }
      
      public function set stackingBlockedMaskBit(param1:int) : void
      {
         var_3465 = 1 << param1;
         var_4366 = var_3465 - 1;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return var_385;
      }
      
      public function getTileHeight(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= _width || param2 < 0 || param2 >= var_385)
         {
            return -1;
         }
         return decodeTileHeight(var_24[param2 * _width + param1]);
      }
      
      public function getStackingBlocked(param1:int, param2:int) : Boolean
      {
         if(param1 < 0 || param1 >= _width || param2 < 0 || param2 >= var_385)
         {
            return true;
         }
         return decodeIsStackingBlocked(var_24[param2 * _width + param1]);
      }
      
      public function isRoomTile(param1:int, param2:int) : Boolean
      {
         if(param1 < 0 || param1 >= _width || param2 < 0 || param2 >= var_385)
         {
            return false;
         }
         return decodeIsRoomTile(var_24[param2 * _width + param1]);
      }
      
      public function flush() : Boolean
      {
         var_24 = null;
         _width = 0;
         var_385 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _width = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         var_385 = _loc3_ / _width;
         var_24 = new Vector.<int>(_loc3_);
         var _loc2_:int = 0;
         while(0 < _loc3_)
         {
            var_24[0] = param1.readShort();
            _loc2_++;
         }
         return true;
      }
   }
}

