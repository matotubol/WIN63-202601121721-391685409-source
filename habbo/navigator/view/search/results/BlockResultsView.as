package com.sulake.habbo.navigator.view.search.results
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import flash.utils.Dictionary;
   import package_25.class_1798;
   import package_25.class_1895;
   
   public class BlockResultsView
   {
      
      private var _navigator:HabboNewNavigator;
      
      private var _itemList:IItemListWindow;
      
      private var var_1578:CategoryElementFactory;
      
      private var var_476:Dictionary = new Dictionary();
      
      private var var_2141:Dictionary = new Dictionary();
      
      private var var_1855:Dictionary = new Dictionary();
      
      public function BlockResultsView(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function get itemList() : IItemListWindow
      {
         return _itemList;
      }
      
      public function set itemList(param1:IItemListWindow) : void
      {
         _itemList = param1;
         _itemList.disableAutodrag = true;
      }
      
      public function set categoryElementFactory(param1:CategoryElementFactory) : void
      {
         var_1578 = param1;
      }
      
      public function displayCurrentResults() : void
      {
         if(_navigator.currentResults == null)
         {
            return;
         }
         var_2141 = new Dictionary();
         var_476 = new Dictionary();
         var_1855 = new Dictionary();
         _itemList.destroyListItems();
         if(_navigator.currentResults.resultSet.blocks.length == 0)
         {
            _itemList.addListItem(var_1578.getNoResultsELement());
         }
         else
         {
            var _loc4_:class_1798 = _navigator.currentResults.resultSet;
            var _loc2_:int = 0;
            while(0 < null.blocks.length)
            {
               var _loc3_:class_1895 = null.blocks[0];
               var _loc1_:class_1741 = renderCurrentResultsBlock(0,(!isMinimized(null.searchCode) || isSingleBlock(null)) && !null.forceClosed);
               null.id = 0;
               _itemList.addListItem(null);
               var_2141[0] = null;
               var_476[0] = null.searchCode;
               var_1855[0] = null.viewMode;
               _loc2_++;
            }
         }
         _itemList.arrangeListItems();
      }
      
      public function onCategoryShowMoreClicked(param1:class_1758) : void
      {
         _navigator.performSearch(var_476[param1.window.id],_navigator.currentResults.filteringData);
         _navigator.trackEventLog("browse.expandsearch","Results",HabboNewNavigator.getEventLogExtraStringFromSearch(var_476[param1.window.id],_navigator.currentResults.filteringData));
      }
      
      public function onCategoryBackClicked(param1:class_1758) : void
      {
         _navigator.goBack();
      }
      
      public function onCategoryCollapseClicked(param1:class_1758) : void
      {
         _navigator.sendAddCollapsedCategory(var_476[param1.window.id]);
         _navigator.collapsedCategories.push(var_476[param1.window.id]);
         replaceBlock(param1.window.id,false);
         _navigator.trackEventLog("browse.collapsecategory","Results",HabboNewNavigator.getEventLogExtraStringFromSearch(var_476[param1.window.id],_navigator.currentResults.filteringData));
      }
      
      public function onCategoryExpandClicked(param1:class_1758) : void
      {
         _navigator.sendRemoveCollapsedCategory(var_476[param1.window.id]);
         _navigator.collapsedCategories.splice(_navigator.collapsedCategories.indexOf(var_476[param1.window.id]),1);
         replaceBlock(param1.window.id,true);
         _navigator.trackEventLog("browse.uncollapsecategory","Results",HabboNewNavigator.getEventLogExtraStringFromSearch(var_476[param1.window.id],_navigator.currentResults.filteringData));
      }
      
      public function onCategoryAddQuickLinkClicked(param1:class_1758) : void
      {
         _navigator.addSavedSearch(var_476[param1.window.id],_navigator.currentResults.filteringData);
      }
      
      public function onCategoryToggleModeClicked(param1:class_1758) : void
      {
         var _loc2_:int = getToggledViewMode(var_1855[param1.window.id]);
         _navigator.toggleSearchCodeViewMode(var_476[param1.window.id],_loc2_);
         _navigator.currentResults.resultSet.blocks[param1.window.id].viewMode = _loc2_;
         replaceBlock(param1.window.id,true);
         var_1855[param1.window.id] = _loc2_;
      }
      
      private function getToggledViewMode(param1:int) : int
      {
         if(param1 == 0)
         {
            return 1;
         }
         return 0;
      }
      
      public function get itemListWidth() : int
      {
         return _itemList.width;
      }
      
      private function isMinimized(param1:String) : Boolean
      {
         return _navigator.collapsedCategories.indexOf(param1) != -1;
      }
      
      private function isSingleBlock(param1:class_1798) : Boolean
      {
         return param1.blocks.length == 1;
      }
      
      private function renderCurrentResultsBlock(param1:int, param2:Boolean) : class_1741
      {
         var _loc5_:int = 0;
         var _loc3_:class_1895 = _navigator.currentResults.resultSet.blocks[param1];
         var _loc4_:String = _loc3_.text == "" ? "${navigator.searchcode.title." + _loc3_.searchCode + "}" : _loc3_.text;
         if(param2)
         {
            _loc5_ = !_navigator.sessionData.isPerkAllowed("NAVIGATOR_ROOM_THUMBNAIL_CAMERA") && _navigator.currentResults.searchCodeOriginal != "official_view" ? 0 : _loc3_.viewMode;
            return var_1578.getOpenCategoryElement(_loc3_.guestRooms,_loc4_,param1,_loc3_.actionAllowed,_loc5_);
         }
         return var_1578.getCollapsedCategoryElement(_loc4_,param1,_loc3_.actionAllowed);
      }
      
      private function replaceBlock(param1:int, param2:Boolean) : void
      {
         var _loc4_:int = _itemList.getListItemIndex(var_2141[param1]);
         _itemList.removeListItemAt(_loc4_);
         var _loc3_:class_1741 = renderCurrentResultsBlock(param1,param2);
         _loc3_.id = param1;
         _itemList.addListItemAt(_loc3_,_loc4_);
         var_2141[param1] = _loc3_;
      }
   }
}

