package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1841;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_2164;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_3348;
   
   [SecureSWF(rename="true")]
   public class RoomSettingsDataEventParser implements IMessageParser
   {
      
      private var var_173:class_1841;
      
      public function RoomSettingsDataEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_173 = new class_1841();
         var_173.roomId = param1.readInteger();
         var_173.name = param1.readString();
         var_173.description = param1.readString();
         var_173.doorMode = param1.readInteger();
         var_173.categoryId = param1.readInteger();
         var_173.maximumVisitors = param1.readInteger();
         var_173.maximumVisitorsLimit = param1.readInteger();
         var_173.tags = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_173.tags.push(param1.readString());
            _loc3_++;
         }
         var_173.tradeMode = param1.readInteger();
         var_173.allowPets = param1.readInteger() == 1;
         var_173.allowFoodConsume = param1.readInteger() == 1;
         var_173.allowWalkThrough = param1.readInteger() == 1;
         var_173.hideWalls = param1.readInteger() == 1;
         var_173.wallThickness = param1.readInteger();
         var_173.floorThickness = param1.readInteger();
         var_173.chatSettings = new class_2164(param1);
         var_173.allowNavigatorDynamicCats = param1.readBoolean();
         var_173.roomModerationSettings = new class_3348(param1);
         var_173.hiddenByBc = param1.readBoolean();
         return true;
      }
      
      public function flush() : Boolean
      {
         var_173 = null;
         return true;
      }
      
      public function get data() : class_1841
      {
         return var_173;
      }
   }
}

