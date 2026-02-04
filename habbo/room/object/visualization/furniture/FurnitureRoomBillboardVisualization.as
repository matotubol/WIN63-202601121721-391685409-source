package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.IRoomObjectModel;
   
   public class FurnitureRoomBillboardVisualization extends FurnitureRoomBrandingVisualization
   {
      
      public function FurnitureRoomBillboardVisualization()
      {
         super();
      }
      
      override protected function getAdClickUrl(param1:IRoomObjectModel) : String
      {
         return param1.getString("furniture_branding_url");
      }
      
      override protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         return super.getSpriteXOffset(param1,param2,param3) + var_3031;
      }
      
      override protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         return super.getSpriteYOffset(param1,param2,param3) + var_2852;
      }
      
      override protected function getSpriteZOffset(param1:int, param2:int, param3:int) : Number
      {
         return super.getSpriteZOffset(param1,param2,param3) + var_3531 * -1;
      }
   }
}

