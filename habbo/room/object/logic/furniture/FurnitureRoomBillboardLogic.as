package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.room.object.IRoomObjectModelController;
   
   public class FurnitureRoomBillboardLogic extends FurnitureRoomBrandingLogic
   {
      
      public function FurnitureRoomBillboardLogic()
      {
         super();
         var_3024 = true;
      }
      
      override protected function getAdClickUrl(param1:IRoomObjectModelController) : String
      {
         return param1.getString("furniture_branding_url");
      }
      
      override protected function handleAdClick(param1:int, param2:String, param3:String) : void
      {
         if(param3.indexOf("http") == 0)
         {
            HabboWebTools.openWebPage(param3);
         }
         else if(eventDispatcher != null)
         {
            eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent("RORAE_ROOM_AD_FURNI_CLICK",object,"",param3));
         }
      }
   }
}

