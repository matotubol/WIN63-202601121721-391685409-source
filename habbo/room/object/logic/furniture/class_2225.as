package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectDataRequestEvent;
   import com.sulake.room.object.IRoomObjectModel;
   
   public class class_2225 extends class_1738
   {
      
      public function class_2225()
      {
         super();
      }
      
      override public function get widget() : String
      {
         return "RWE_RENTABLESPACE";
      }
      
      override public function getEventTypes() : Array
      {
         return getAllEventTypes(super.getEventTypes(),["RODRE_CURRENT_USER_ID"]);
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         if(!object.getModel().hasNumber("session_current_user_id"))
         {
            eventDispatcher.dispatchEvent(new RoomObjectDataRequestEvent("RODRE_CURRENT_USER_ID",object));
         }
         var _loc4_:IRoomObjectModel = object.getModel();
         var _loc2_:String = _loc4_.getStringToStringMap("furniture_data").getValue("renterId");
         var _loc3_:Number = _loc4_.getNumber("session_current_user_id");
         if(_loc2_ != null)
         {
            if(Number(_loc2_) == _loc3_)
            {
               object.setState(2,0);
            }
            else
            {
               object.setState(1,0);
            }
         }
         else
         {
            object.setState(0,0);
         }
      }
   }
}

