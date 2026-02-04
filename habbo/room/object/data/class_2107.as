package com.sulake.habbo.room.object.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.IRoomObjectModelController;
   import package_69.JSONDecoder;
   
   public class class_2107 implements IStuffData
   {
      
      private var var_2654:int;
      
      private var _uniqueSerialNumber:int = 0;
      
      private var var_1620:int = 0;
      
      public function class_2107()
      {
         super();
      }
      
      public function set flags(param1:int) : void
      {
         var_2654 = param1;
      }
      
      public function initializeFromIncomingMessage(param1:IMessageDataWrapper) : void
      {
         if((var_2654 & 0x0100) > 0)
         {
            _uniqueSerialNumber = param1.readInteger();
            var_1620 = param1.readInteger();
         }
      }
      
      public function initializeFromRoomObjectModel(param1:IRoomObjectModel) : void
      {
         _uniqueSerialNumber = param1.getNumber("furniture_unique_serial_number");
         var_1620 = param1.getNumber("furniture_unique_edition_size");
      }
      
      public function writeRoomObjectModel(param1:IRoomObjectModelController) : void
      {
         param1.setNumber("furniture_unique_serial_number",_uniqueSerialNumber);
         param1.setNumber("furniture_unique_edition_size",var_1620);
      }
      
      public function get uniqueSerialNumber() : int
      {
         return _uniqueSerialNumber;
      }
      
      public function get uniqueSeriesSize() : int
      {
         return var_1620;
      }
      
      public function set uniqueSerialNumber(param1:int) : void
      {
         _uniqueSerialNumber = param1;
      }
      
      public function set uniqueSeriesSize(param1:int) : void
      {
         var_1620 = param1;
      }
      
      public function getLegacyString() : String
      {
         return "";
      }
      
      public function compare(param1:IStuffData) : Boolean
      {
         return false;
      }
      
      public function get rarityLevel() : int
      {
         return -1;
      }
      
      public function get state() : int
      {
         var _loc1_:Number = Number(getLegacyString());
         return isNaN(_loc1_) ? -1 : int(_loc1_);
      }
      
      public function getJSONValue(param1:String) : String
      {
         var _loc2_:* = null;
         try
         {
            return new JSONDecoder(getLegacyString(),true).getValue()[param1];
         }
         catch(error:Error)
         {
            var _loc5_:String = "";
         }
         return _loc5_;
      }
   }
}

