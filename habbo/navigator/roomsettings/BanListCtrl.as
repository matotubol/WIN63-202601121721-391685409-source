package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.class_42;
   
   public class BanListCtrl extends UserListCtrl
   {
      
      private var var_361:int = -1;
      
      public function BanListCtrl(param1:class_42)
      {
         super(param1,false);
      }
      
      override protected function getRowView() : class_1812
      {
         return class_1812(_navigator.getXmlWindow("ros_banned_user"));
      }
      
      override protected function onBgMouseClick(param1:class_1758) : void
      {
         var_361 = param1.target.parent.id;
         refreshColorsAfterClick(param1.target.findParentByName("moderation_banned_users") as IItemListWindow);
      }
      
      override protected function getBgColor(param1:int, param2:Boolean) : uint
      {
         if(param1 == var_361)
         {
            return 4288329945;
         }
         return super.getBgColor(param1,param2);
      }
      
      private function refreshColorsAfterClick(param1:IItemListWindow) : void
      {
         var _loc3_:int = 0;
         var _loc2_:class_1812 = null;
         _loc3_ = 0;
         while(_loc3_ < var_3244)
         {
            _loc2_ = class_1812(param1.getListItemAt(_loc3_));
            _loc2_.color = this.getBgColor(_loc3_,false);
            _loc3_++;
         }
      }
      
      public function get selectedRow() : int
      {
         return var_361;
      }
   }
}

