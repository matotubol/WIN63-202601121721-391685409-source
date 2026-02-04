package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.class_2201;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.enum.class_2522;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import package_3.class_1763;
   import package_3.class_2981;
   import package_9.class_1796;
   
   public class BadgeImageWidget implements class_3087
   {
      
      public static const TYPE:String = "badge_image";
      
      private static const const_764:String = "badge_image:type";
      
      private static const const_707:String = "badge_image:badge_id";
      
      private static const TYPE_DEFAULT:PropertyStruct = new PropertyStruct("badge_image:type","normal","String",false,class_2522.ALL);
      
      private static const ID_DEFAULT:PropertyStruct = new PropertyStruct("badge_image:badge_id","","String");
      
      private var _disposed:Boolean;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_1899:Boolean;
      
      private var var_134:class_1812;
      
      private var _bitmap:IStaticBitmapWrapperWindow;
      
      private var var_308:IRegionWindow;
      
      private var var_230:String = String(TYPE_DEFAULT.value);
      
      private var var_605:String = String(ID_DEFAULT.value);
      
      private var _groupId:int;
      
      private var var_2554:class_1763;
      
      private var var_1600:class_2981;
      
      public function BadgeImageWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("badge_image_xml").content as XML) as class_1812;
         _bitmap = var_134.findChildByName("bitmap") as IStaticBitmapWrapperWindow;
         var_308 = var_134.findChildByName("region") as IRegionWindow;
         var_308.addEventListener("WME_CLICK",onClick);
         var_210.rootWindow = var_134;
         var_134.width = var_210.width;
         var_134.height = var_210.height;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            groupId = 0;
            if(var_308 != null)
            {
               var_308.removeEventListener("WME_CLICK",onClick);
               var_308.dispose();
               var_308 = null;
            }
            _bitmap = null;
            if(var_134 != null)
            {
               var_134.dispose();
               var_134 = null;
            }
            if(var_210 != null)
            {
               var_210.rootWindow = null;
               var_210 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get properties() : Array
      {
         var _loc2_:Array = [];
         if(_disposed)
         {
            return _loc2_;
         }
         _loc2_.push(TYPE_DEFAULT.withValue(var_230));
         _loc2_.push(ID_DEFAULT.withValue(var_605));
         for each(var _loc1_ in _bitmap.properties)
         {
            if(_loc1_.key != "asset_uri")
            {
               _loc2_.push(_loc1_.withNameSpace("badge_image"));
            }
         }
         return _loc2_;
      }
      
      public function set properties(param1:Array) : void
      {
         var_1899 = true;
         var _loc3_:Array = [];
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "badge_image:type":
                  type = String(_loc2_.value);
                  break;
               case "badge_image:badge_id":
                  badgeId = String(_loc2_.value);
            }
            if(_loc2_.key != "badge_image:asset_uri")
            {
               _loc3_.push(_loc2_.withoutNameSpace());
            }
         }
         _bitmap.properties = _loc3_;
         var_1899 = false;
         refresh();
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function set type(param1:String) : void
      {
         var_230 = param1;
         refresh();
      }
      
      public function get badgeId() : String
      {
         return var_605;
      }
      
      public function set badgeId(param1:String) : void
      {
         var_605 = param1;
         refresh();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
         var _loc2_:Boolean = var_230 == "group" && _groupId > 0;
         if(_windowManager != null && _windowManager.communication != null)
         {
            if(!_loc2_ && var_1600 != null)
            {
               _windowManager.communication.removeHabboConnectionMessageEvent(var_2554);
               _windowManager.communication.removeHabboConnectionMessageEvent(var_1600);
               var_2554 = null;
               var_1600 = null;
            }
            else if(_loc2_ && var_1600 == null)
            {
               var_2554 = new class_1763(onGroupDetailsChanged);
               var_1600 = new class_2981(onHabboGroupBadges);
               _windowManager.communication.addHabboConnectionMessageEvent(var_2554);
               _windowManager.communication.addHabboConnectionMessageEvent(var_1600);
            }
         }
      }
      
      public function get bitmapData() : BitmapData
      {
         return class_2201(_bitmap).bitmapData;
      }
      
      public function get pivotPoint() : uint
      {
         return _bitmap.pivotPoint;
      }
      
      public function set pivotPoint(param1:uint) : void
      {
         _bitmap.pivotPoint = param1;
         _bitmap.invalidate();
      }
      
      public function get stretchedX() : Boolean
      {
         return _bitmap.stretchedX;
      }
      
      public function set stretchedX(param1:Boolean) : void
      {
         _bitmap.stretchedX = param1;
         _bitmap.invalidate();
      }
      
      public function get stretchedY() : Boolean
      {
         return _bitmap.stretchedY;
      }
      
      public function set stretchedY(param1:Boolean) : void
      {
         _bitmap.stretchedY = param1;
         _bitmap.invalidate();
      }
      
      public function get zoomX() : Number
      {
         return _bitmap.zoomX;
      }
      
      public function set zoomX(param1:Number) : void
      {
         _bitmap.zoomX = param1;
         _bitmap.invalidate();
      }
      
      public function get zoomY() : Number
      {
         return _bitmap.zoomY;
      }
      
      public function set zoomY(param1:Number) : void
      {
         _bitmap.zoomY = param1;
         _bitmap.invalidate();
      }
      
      public function get greyscale() : Boolean
      {
         return _bitmap.greyscale;
      }
      
      public function set greyscale(param1:Boolean) : void
      {
         _bitmap.greyscale = param1;
         _bitmap.invalidate();
      }
      
      public function get etchingColor() : uint
      {
         return _bitmap.etchingColor;
      }
      
      public function set etchingColor(param1:uint) : void
      {
         _bitmap.etchingColor = param1;
         _bitmap.invalidate();
      }
      
      public function get fitSizeToContents() : Boolean
      {
         return _bitmap.fitSizeToContents;
      }
      
      public function set fitSizeToContents(param1:Boolean) : void
      {
         _bitmap.fitSizeToContents = param1;
         _bitmap.invalidate();
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         if(_groupId > 0)
         {
            _windowManager.communication.connection.send(new class_1796(_groupId,true));
         }
      }
      
      public function refresh() : void
      {
         if(var_1899)
         {
            return;
         }
         _bitmap.assetUri = assetUri;
         _bitmap.blend = var_210.blend;
         _bitmap.invalidate();
      }
      
      private function get assetUri() : String
      {
         var _loc1_:String = "";
         if(var_605 != null && var_605.length > 0)
         {
            switch(var_230)
            {
               case "normal":
                  _loc1_ = "${image.library.url}album1584/" + var_605 + ".png";
                  break;
               case "group":
                  _loc1_ = _windowManager.getProperty("group.badge.url").replace("%imagerdata%",var_605);
                  break;
               case "perk":
                  _loc1_ = "${image.library.url}perk/" + var_605 + ".png";
            }
         }
         return _loc1_;
      }
      
      private function forceRefresh(param1:int, param2:String) : void
      {
         if(param1 != _groupId)
         {
            return;
         }
         var_605 = param2;
         _windowManager.resourceManager.removeAsset(assetUri);
         refresh();
      }
      
      private function onGroupDetailsChanged(param1:class_1763) : void
      {
         forceRefresh(param1.groupId,var_605);
      }
      
      private function onHabboGroupBadges(param1:class_2981) : void
      {
         if(param1.badges.hasKey(_groupId))
         {
            forceRefresh(_groupId,param1.badges[_groupId]);
         }
      }
      
      public function get etchingPoint() : Point
      {
         return new Point(0,1);
      }
      
      public function get wrapX() : Boolean
      {
         return false;
      }
      
      public function set wrapX(param1:Boolean) : void
      {
      }
      
      public function get wrapY() : Boolean
      {
         return false;
      }
      
      public function set wrapY(param1:Boolean) : void
      {
      }
      
      public function get rotation() : Number
      {
         return 0;
      }
      
      public function set rotation(param1:Number) : void
      {
      }
   }
}

