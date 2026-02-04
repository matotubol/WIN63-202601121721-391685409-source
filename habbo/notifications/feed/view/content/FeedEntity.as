package com.sulake.habbo.notifications.feed.view.content
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.notifications.feed.NotificationController;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.net.URLRequest;
   
   public class FeedEntity implements class_3007
   {
      
      public static var name_3:class_1812;
      
      public static var var_3231:class_27;
      
      public static var ASSETS:class_40;
      
      public static var FEED_CONTROLLER:NotificationController;
      
      protected static const LIST:String = "content_list";
      
      protected static const TITLE:String = "title";
      
      protected static const MESSAGE:String = "message";
      
      protected static const TIME:String = "time";
      
      protected static const ICON:String = "icon";
      
      protected static const DECORATION:String = "decoration";
      
      protected static const ACTION_BUTTON:String = "action_button";
      
      protected static const UNIT_MINUTES:String = "minutes";
      
      protected static const UNIT_HOURS:String = "hours";
      
      protected static const const_955:String = "days";
      
      private static const BUTTON_HEIGHT:int = 25;
      
      private static const const_15:Vector.<FeedEntity> = new Vector.<FeedEntity>();
      
      protected var _window:class_1812;
      
      protected var _disposed:Boolean = false;
      
      protected var var_123:Boolean = false;
      
      protected var var_197:int = -1;
      
      protected var var_3039:int;
      
      protected var _iconFilePath:String;
      
      protected var _decorationFilePath:String;
      
      protected var var_3656:String;
      
      public function FeedEntity()
      {
         super();
         _window = name_3.clone() as class_1812;
      }
      
      public static function assignHandles(param1:class_38, param2:class_40, param3:class_27, param4:NotificationController) : void
      {
         name_3 = param1.buildFromXML(param2.getAssetByName("feed_entity_xml").content as XML) as class_1812;
         ASSETS = param2;
         var_3231 = param3;
         FEED_CONTROLLER = param4;
      }
      
      public static function removeHandles() : void
      {
         if(name_3)
         {
            name_3.dispose();
            name_3 = null;
         }
         ASSETS = null;
         var_3231 = null;
         FEED_CONTROLLER = null;
      }
      
      public static function allocate() : FeedEntity
      {
         var _loc1_:FeedEntity = const_15.length > 0 ? const_15.pop() : new FeedEntity();
         _loc1_.var_123 = false;
         return _loc1_;
      }
      
      public function set id(param1:int) : void
      {
         var_197 = param1;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function set title(param1:String) : void
      {
         _window.findChildByName("title").caption = param1 ? param1 : "";
      }
      
      public function get title() : String
      {
         return _window ? _window.findChildByName("title").caption : null;
      }
      
      public function set message(param1:String) : void
      {
         _window.findChildByName("message").caption = param1 ? param1 : "";
      }
      
      public function get message() : String
      {
         return _window ? _window.findChildByName("message").caption : null;
      }
      
      public function setButton(param1:String, param2:String) : void
      {
         if(!_window)
         {
            return;
         }
         var_3656 = param1;
         var _loc3_:class_1775 = _window.findChildByName("action_button") as class_1775;
         if(var_3656 == null)
         {
            _loc3_.height = 0;
         }
         else
         {
            _loc3_.height = 25;
            _loc3_.caption = param2;
            _loc3_.addEventListener("WME_CLICK",onActionButton);
         }
      }
      
      public function set iconFilePath(param1:String) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1 != _iconFilePath)
         {
            _iconFilePath = param1;
            var _loc2_:IAsset = ASSETS.getAssetByName(param1);
            loadImageUrl(param1);
         }
      }
      
      public function set decorationFilePath(param1:String) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1 != _decorationFilePath)
         {
            _decorationFilePath = param1;
            var _loc2_:IAsset = ASSETS.getAssetByName(param1);
            loadImageUrl(param1);
         }
      }
      
      public function set icon(param1:BitmapData) : void
      {
         if(disposed || !_window)
         {
            return;
         }
         var _loc2_:class_2251 = _window.findChildByName("icon") as class_2251;
         updateImage(_loc2_,param1);
         _iconFilePath = null;
      }
      
      public function set decoration(param1:BitmapData) : void
      {
         if(disposed || !_window)
         {
            return;
         }
         var _loc2_:class_2251 = _window.findChildByName("decoration") as class_2251;
         updateImage(_loc2_,param1);
         _decorationFilePath = null;
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get recycled() : Boolean
      {
         return var_123;
      }
      
      public function set minutesElapsed(param1:int) : void
      {
         var _loc4_:ITextWindow = _window.findChildByName("time") as ITextWindow;
         if(param1 < 0)
         {
            _loc4_.height = 0;
            return;
         }
         var_3039 = param1;
         var _loc3_:String = "minutes";
         if(var_3039 >= 1440)
         {
            _loc3_ = "days";
            param1 /= 1440;
         }
         else if(var_3039 >= 60)
         {
            _loc3_ = "hours";
            param1 /= 60;
         }
         var _loc2_:ILocalization = var_3231.getLocalizationRaw("friendbar.stream." + _loc3_ + ".ago");
         _loc4_.caption = _loc2_ ? _loc2_.raw.replace("%value%",String(param1)) : "...?";
      }
      
      public function get minutesElapsed() : int
      {
         return var_3039;
      }
      
      public function updateContainerSize() : void
      {
         if(!_window || disposed)
         {
            return;
         }
         var _loc2_:IItemListWindow = _window.findChildByName("content_list") as IItemListWindow;
         var _loc1_:class_1741 = _loc2_.getListItemAt(_loc2_.numListItems - 1) as class_1741;
         _loc2_.height = _loc1_ ? _loc1_.y + _loc1_.height : 0;
      }
      
      public function recycle() : void
      {
         if(!var_123)
         {
            if(!_disposed)
            {
               _window.parent = null;
               class_2251(_window.findChildByName("decoration")).bitmap = null;
               class_2251(_window.findChildByName("icon")).bitmap = null;
               (_window.findChildByName("action_button") as class_1775).removeEventListener("WME_CLICK",onActionButton);
               _decorationFilePath = null;
               var_123 = true;
               const_15.push(this);
            }
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
            if(var_123)
            {
               const_15.splice(const_15.indexOf(this),1);
               var_123 = false;
            }
            _disposed = true;
         }
      }
      
      protected function onActionButton(param1:WindowMouseEvent) : void
      {
         FEED_CONTROLLER.executeAction(var_3656);
      }
      
      private function updateImage(param1:class_2251, param2:BitmapData) : void
      {
         if(param2 == null)
         {
            param1.bitmap = null;
            param1.height = 0;
            return;
         }
         var _loc4_:Number = param1.x + param1.width / 2;
         var _loc3_:Number = param1.y + param1.height / 2;
         param1.bitmap = param2;
         param1.x = _loc4_ - param2.width / 2;
         param1.y = _loc3_ - param2.height / 2;
         param1.width = param2.width;
         param1.height = param2.height;
      }
      
      private function loadImageUrl(param1:String) : void
      {
         var _loc2_:AssetLoaderStruct = ASSETS.loadAssetFromFile(param1,new URLRequest(param1));
         _loc2_.addEventListener("AssetLoaderEventComplete",onImageFileLoaded);
         _loc2_.addEventListener("AssetLoaderEventError",onImageFileLoaded);
      }
      
      private function onImageFileLoaded(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = null;
         var _loc3_:IAsset = null;
         if(param1.type == "AssetLoaderEventComplete")
         {
            _loc2_ = param1.target as AssetLoaderStruct;
            if(_loc2_.assetName == _decorationFilePath)
            {
               _loc3_ = ASSETS.getAssetByName(_decorationFilePath);
               if(_loc3_)
               {
                  decoration = _loc3_.content as BitmapData;
               }
            }
            else if(_loc2_.assetName == _iconFilePath)
            {
               _loc3_ = ASSETS.getAssetByName(_iconFilePath);
               if(_loc3_)
               {
                  icon = _loc3_.content as BitmapData;
               }
            }
            updateContainerSize();
         }
      }
   }
}

