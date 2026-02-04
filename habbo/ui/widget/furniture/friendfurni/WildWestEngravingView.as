package com.sulake.habbo.ui.widget.furniture.friendfurni
{
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   
   public class WildWestEngravingView extends FriendFurniEngravingView
   {
      
      public function WildWestEngravingView(param1:FriendFurniEngravingWidget, param2:StringArrayStuffData)
      {
         super(param1,param2);
      }
      
      override protected function assetName() : String
      {
         return "wildwest_engraving_xml";
      }
   }
}

