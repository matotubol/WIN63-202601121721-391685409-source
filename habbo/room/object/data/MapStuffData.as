package com.sulake.habbo.room.object.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.room.*;
   import com.sulake.habbo.room.object.*;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.IRoomObjectModelController;
   
   public class MapStuffData extends class_2107 implements IStuffData
   {
      
      public static const FORMAT_KEY:int = 1;
      
      private static const STATE_DEFAULT_KEY:String = "state";
      
      private static const const_1013:String = "rarity";
      
      private var var_24:class_55;
      
      public function MapStuffData(param1:class_55 = null)
      {
         super();
         if(param1)
         {
            var_24 = param1;
         }
      }
      
      override public function initializeFromIncomingMessage(param1:IMessageDataWrapper) : void
      {
         var_24 = new class_55();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var _loc5_:String = param1.readString();
            var _loc4_:String = param1.readString();
            var_24.add(null,null);
            _loc3_++;
         }
         super.initializeFromIncomingMessage(param1);
      }
      
      override public function initializeFromRoomObjectModel(param1:IRoomObjectModel) : void
      {
         super.initializeFromRoomObjectModel(param1);
         var_24 = param1.getStringToStringMap("furniture_data");
      }
      
      override public function writeRoomObjectModel(param1:IRoomObjectModelController) : void
      {
         super.writeRoomObjectModel(param1);
         param1.setNumber("furniture_data_format",1);
         param1.setStringToStringMap("furniture_data",var_24);
      }
      
      override public function getLegacyString() : String
      {
         if(var_24 && var_24.getValue("state") != null)
         {
            return var_24["state"];
         }
         return "";
      }
      
      public function getValue(param1:String) : String
      {
         return var_24[param1];
      }
      
      override public function compare(param1:IStuffData) : Boolean
      {
         return false;
      }
      
      override public function get rarityLevel() : int
      {
         var _loc1_:String = var_24["rarity"];
         if(_loc1_)
         {
            return int(_loc1_);
         }
         return -1;
      }
   }
}

