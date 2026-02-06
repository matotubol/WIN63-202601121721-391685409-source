package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.IViewCtrl;
   import com.sulake.habbo.navigator.UserCountRenderer;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_3364;
   
   public class CategoryListCtrl implements IViewCtrl
   {
      
      private static const CATEGORY_SPACING:int = 5;
      
      private var var_1577:UserCountRenderer;
      
      private var _navigator:HabboNavigator;
      
      private var _content:class_1812;
      
      private var var_121:IItemListWindow;
      
      private var var_818:IScrollbarWindow;
      
      public function CategoryListCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var_1577 = new UserCountRenderer(_navigator);
      }
      
      public function dispose() : void
      {
         if(var_1577)
         {
            var_1577.dispose();
            var_1577 = null;
         }
      }
      
      public function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc1_:class_3364 = null;
         var _loc6_:Array = _navigator.data.allCategories;
         var _loc7_:class_55 = _navigator.data.categoriesWithVisitorData.categoryToCurrentUserCountMap;
         var _loc8_:class_55 = _navigator.data.categoriesWithVisitorData.categoryToMaxUserCountMap;
         var _loc9_:class_1812 = class_1812(var_121.getListItemAt(0));
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc1_ = _loc6_[_loc4_];
            if(_loc1_.visible)
            {
               var _loc10_:class_1812 = getCategoryContainer(_loc9_,_loc4_);
               if(_loc10_ == null)
               {
                  _loc10_ = createEntry(_loc4_);
                  _loc10_.id = _loc4_;
                  _loc9_.addChild(null);
               }
               var _loc2_:int = _loc7_.getValue(_loc1_.nodeId);
               var _loc5_:int = _loc8_.getValue(_loc1_.nodeId);
               refreshEntry(null,_loc1_,0,0);
               null.y = 0;
               var _loc3_:int = 0 + (null.height + 5);
               null.visible = true;
               _loc9_.height = Util.getLowestPoint(_loc9_) > 0 ? Util.getLowestPoint(_loc9_) + 5 : 0;
            }
            _loc4_++;
         }
         if(var_818 != null)
         {
            var_818.scrollV = 0;
            var_818.visible = true;
         }
      }
      
      public function refreshEntry(param1:class_1812, param2:class_3364, param3:int, param4:int) : void
      {
         param1.findChildByName("category_name_txt").caption = param2.visibleName;
         param1.findChildByName("arrow_right_icon").visible = true;
         var_1577.refreshUserCount(param4,class_1812(param1.findChildByName("enter_category_button")),param3,"${navigator.usercounttooltip.users}",297,35);
      }
      
      public function createEntry(param1:int) : class_1812
      {
         var _loc2_:class_1812 = class_1812(_navigator.getXmlWindow("grs_category_selector"));
         setProcedureAndId(_loc2_,param1,"enter_category_button",onSelectCategory);
         _navigator.refreshButton(_loc2_,"navi_room_icon",true,null,0);
         return _loc2_;
      }
      
      private function onSelectCategory(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var _loc3_:class_3364 = _navigator.data.allCategories[param2.id];
            _navigator.mainViewCtrl.startSearch(2,1,"" + null.nodeId);
         }
      }
      
      private function getCategoryContainer(param1:class_1812, param2:int) : class_1812
      {
         return class_1812(param1.getChildByID(param2));
      }
      
      private function setProcedureAndId(param1:class_1812, param2:int, param3:String, param4:Function) : void
      {
         param1.findChildByName(param3).procedure = param4;
         param1.findChildByName(param3).id = param2;
      }
      
      public function set content(param1:class_1812) : void
      {
         _content = param1;
         var_121 = _content ? IItemListWindow(_content.findChildByName("item_list_category")) : null;
         var_818 = _content ? IScrollbarWindow(_content.findChildByName("scroller")) : null;
      }
      
      public function get content() : class_1812
      {
         return _content;
      }
   }
}

