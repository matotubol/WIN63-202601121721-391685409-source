package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class SaveRoomSettingsMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function SaveRoomSettingsMessageComposer(param1:class_3235)
      {
         super();
         var_120.push(param1.roomId);
         var_120.push(param1.name);
         var_120.push(param1.description);
         var_120.push(param1.doorMode);
         var_120.push(param1.password !== null ? param1.password : "");
         var_120.push(param1.maximumVisitors);
         var_120.push(param1.categoryId);
         if(param1.tags)
         {
            var _loc4_:Array = [];
            for each(var _loc3_ in param1.tags)
            {
               if(_loc3_ && _loc3_ !== "")
               {
                  null.push(_loc3_);
               }
            }
            var_120.push(null.length);
            for each(var _loc2_ in null)
            {
               var_120.push(_loc2_);
            }
         }
         else
         {
            var_120.push(0);
         }
         var_120.push(param1.tradeMode);
         var_120.push(param1.allowPets);
         var_120.push(param1.allowFoodConsume);
         var_120.push(param1.allowWalkThrough);
         var_120.push(param1.hideWalls);
         var_120.push(param1.wallThickness);
         var_120.push(param1.floorThickness);
         var_120.push(param1.whoCanMute);
         var_120.push(param1.whoCanKick);
         var_120.push(param1.whoCanBan);
         var_120.push(param1.chatMode);
         var_120.push(param1.chatBubbleSize);
         var_120.push(param1.chatScrollUpFrequency);
         var_120.push(param1.chatFullHearRange);
         var_120.push(param1.chatFloodSensitivity);
         var_120.push(param1.allowNavigatorDynCats);
      }
      
      public function getMessageArray() : Array
      {
         return var_120;
      }
      
      public function dispose() : void
      {
         var_120 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

