package com.sulake.habbo.moderation
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   import flash.utils.getTimer;
   import package_79.class_3291;
   
   public class IssueListView
   {
      
      private var var_1945:IssueManager;
      
      private var var_1425:IssueBrowser;
      
      private var var_121:IItemListWindow;
      
      private var var_3400:class_1812;
      
      private var var_5400:BitmapData;
      
      private var var_5377:BitmapData;
      
      private var var_2778:int = 200;
      
      public function IssueListView(param1:IssueManager, param2:IssueBrowser, param3:IItemListWindow)
      {
         super();
         var_1945 = param1;
         var_1425 = param2;
         var_121 = param3;
         var_3400 = param3.getListItemAt(0) as class_1812;
         param3.removeListItems();
         var_2778 = param1.issueListLimit;
      }
      
      public function update(param1:Array) : void
      {
         var _loc9_:int = 0;
         var _loc2_:class_1812 = null;
         var _loc3_:class_1741 = null;
         var _loc14_:class_1741 = null;
         var _loc12_:* = null;
         var _loc6_:class_3291 = null;
         var _loc8_:class_2251 = null;
         var _loc10_:String = null;
         var _loc11_:BitmapDataAsset = null;
         var _loc4_:BitmapData = null;
         if(var_121 == null)
         {
            return;
         }
         if(param1 == null || param1.length == 0)
         {
            var_121.destroyListItems();
            return;
         }
         param1.sortOn(["highestPriority","issueAgeInMilliseconds"],[16,16]);
         var _loc13_:int = var_121.numListItems;
         var _loc5_:int = int(param1.length);
         if(_loc5_ > var_2778)
         {
            _loc5_ = var_2778;
         }
         if(_loc13_ < _loc5_)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc5_ - _loc13_)
            {
               _loc2_ = var_3400.clone() as class_1812;
               var_121.addListItem(_loc2_);
               _loc9_++;
            }
         }
         else if(_loc13_ > _loc5_)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc13_ - _loc5_)
            {
               _loc3_ = var_121.removeListItemAt(0);
               _loc3_.dispose();
               _loc9_++;
            }
         }
         _loc9_ = 1;
         var _loc7_:int = getTimer();
         for each(_loc12_ in param1)
         {
            if(_loc9_ > var_2778)
            {
               break;
            }
            if(_loc12_ == null || var_3400 == null)
            {
               return;
            }
            _loc2_ = var_121.getListItemAt(_loc9_ - 1) as class_1812;
            if(_loc2_ == null)
            {
               return;
            }
            _loc2_.width = var_121.width;
            _loc2_.color = _loc9_++ % 2 ? 4289914618 : 4294967295;
            _loc14_ = _loc2_.findChildByName("score");
            if(_loc14_ != null)
            {
               _loc14_.caption = _loc12_.highestPriority.toString();
            }
            _loc6_ = _loc12_.getHighestPriorityIssue();
            if(_loc6_ == null)
            {
               return;
            }
            _loc14_ = _loc2_.findChildByName("source");
            if(_loc14_ != null)
            {
               _loc14_.caption = class_2078.getSourceName(_loc6_.categoryId);
            }
            _loc14_ = _loc2_.findChildByName("category");
            if(_loc14_ != null)
            {
               _loc14_.caption = class_2078.getCategoryName(_loc6_.reportedCategoryId);
            }
            _loc14_ = _loc2_.findChildByName("target_name");
            if(_loc14_ != null)
            {
               if(_loc6_.reportedUserId != 0)
               {
                  _loc14_.caption = _loc6_.reportedUserName;
               }
               else
               {
                  _loc14_.caption = "";
               }
            }
            _loc8_ = _loc2_.findChildByName("target_icon") as class_2251;
            if(_loc8_ != null)
            {
               _loc10_ = _loc6_.reportedUserId ? "user_icon_png" : "room_icon_png";
               _loc11_ = var_1425.assets.getAssetByName(_loc10_) as BitmapDataAsset;
               if(_loc11_ != null && _loc11_.content as BitmapData != null)
               {
                  _loc4_ = _loc11_.content as BitmapData;
                  if(_loc4_ != null)
                  {
                     _loc8_.bitmap = _loc4_.clone();
                  }
               }
            }
            _loc14_ = _loc2_.findChildByName("time");
            if(_loc14_ != null)
            {
               _loc14_.caption = _loc12_.getOpenTime(_loc7_);
            }
            _loc14_ = _loc2_.findChildByName("msgs");
            if(_loc14_ != null)
            {
               _loc14_.caption = _loc12_.getMessageCount().toString();
            }
            _loc14_ = _loc2_.findChildByName("picker");
            if(_loc14_ != null)
            {
               _loc14_.caption = _loc12_.pickerName;
            }
            _loc14_ = _loc2_.findChildByName("pick_button");
            if(_loc14_ != null)
            {
               _loc14_.id = _loc12_.id;
               _loc14_.removeEventListener("WME_CLICK",onPick);
               _loc14_.addEventListener("WME_CLICK",onPick);
            }
            _loc14_ = _loc2_.findChildByName("handle_button");
            if(_loc14_ != null)
            {
               _loc14_.id = _loc12_.id;
               _loc14_.removeEventListener("WME_CLICK",onHandle);
               _loc14_.addEventListener("WME_CLICK",onHandle);
            }
            _loc14_ = _loc2_.findChildByName("release_button");
            if(_loc14_ != null)
            {
               _loc14_.id = _loc12_.id;
               _loc14_.removeEventListener("WME_CLICK",onRelease);
               _loc14_.addEventListener("WME_CLICK",onRelease);
            }
         }
      }
      
      private function onPick(param1:WindowMouseEvent) : void
      {
         if(var_1945 == null)
         {
            return;
         }
         var_1945.pickBundle(param1.window.id,"pick button");
      }
      
      private function onHandle(param1:WindowMouseEvent) : void
      {
         if(var_1425 == null)
         {
            return;
         }
         var_1945.handleBundle(param1.window.id);
      }
      
      private function onRelease(param1:WindowMouseEvent) : void
      {
         if(var_1945 == null)
         {
            return;
         }
         var_1945.releaseBundle(param1.window.id);
      }
   }
}

