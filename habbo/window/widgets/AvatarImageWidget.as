package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   
   public class AvatarImageWidget implements class_2478, class_259
   {
      
      public static const TYPE:String = "avatar_image";
      
      private static const FIGURE_KEY:String = "avatar_image:figure";
      
      private static const SCALE_KEY:String = "avatar_image:scale";
      
      private static const const_1085:String = "avatar_image:only_head";
      
      private static const CROPPED_KEY:String = "avatar_image:cropped";
      
      private static const const_295:String = "avatar_image:direction";
      
      private static const const_12:Array = ["northeast","east","southeast","south","southwest","west","northwest","north"];
      
      private static const FIGURE_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:figure","hd-180-1.ch-210-66.lg-270-82.sh-290-81","String");
      
      private static const SCALE_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:scale","h","String",false,["sh","h"]);
      
      private static const ONLY_HEAD_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:only_head",false,"Boolean");
      
      private static const CROPPED_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:cropped",false,"Boolean");
      
      private static const DIRECTION_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:direction",const_12[2],"String",false,const_12);
      
      private var _disposed:Boolean;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:class_1812;
      
      private var _bitmap:class_2251;
      
      private var var_308:IRegionWindow;
      
      private var var_975:String = String(FIGURE_DEFAULT.value);
      
      private var var_4523:Boolean = false;
      
      private var var_337:String = String(SCALE_DEFAULT.value);
      
      private var var_938:Boolean = Boolean(ONLY_HEAD_DEFAULT.value);
      
      private var _cropped:Boolean = Boolean(CROPPED_DEFAULT.value);
      
      private var var_81:int = const_12.indexOf(String(DIRECTION_DEFAULT.value));
      
      private var var_1270:int;
      
      private var var_2274:Boolean;
      
      private const rc:Number = 0.3333333333333333;
      
      private const gc:Number = 0.3333333333333333;
      
      private const bc:Number = 0.3333333333333333;
      
      public function AvatarImageWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("avatar_image_xml").content as XML) as class_1812;
         _bitmap = var_134.findChildByName("bitmap") as class_2251;
         var_308 = var_134.findChildByName("region") as IRegionWindow;
         var_308.addEventListener("WME_CLICK",onClick);
         refresh();
         var_210.rootWindow = var_134;
         var_134.width = var_210.width;
         var_134.height = var_210.height;
      }
      
      private static function cleanupAvatarString(param1:String) : String
      {
         return param1 == null || param1.length == 0 ? String(FIGURE_DEFAULT.value) : param1.replace(/NaN/g,"");
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
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
            if(var_2274)
            {
               _windowManager.avatarRenderer.events.removeEventListener("AVATAR_RENDER_READY",onAvatarRendererReady);
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
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(FIGURE_DEFAULT.withValue(var_975));
         _loc1_.push(SCALE_DEFAULT.withValue(var_337));
         _loc1_.push(ONLY_HEAD_DEFAULT.withValue(var_938));
         _loc1_.push(CROPPED_DEFAULT.withValue(_cropped));
         _loc1_.push(DIRECTION_DEFAULT.withValue(const_12[var_81]));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "avatar_image:figure":
                  figure = String(_loc2_.value);
                  break;
               case "avatar_image:scale":
                  scale = String(_loc2_.value);
                  break;
               case "avatar_image:only_head":
                  onlyHead = Boolean(_loc2_.value);
                  break;
               case "avatar_image:cropped":
                  cropped = Boolean(_loc2_.value);
                  break;
               case "avatar_image:direction":
                  direction = const_12.indexOf(String(_loc2_.value));
            }
         }
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function set figure(param1:String) : void
      {
         if(param1 != var_975)
         {
            var_4523 = param1 == null || param1.length == 0;
            var_975 = cleanupAvatarString(param1);
            refresh();
         }
      }
      
      public function get scale() : String
      {
         return var_337;
      }
      
      public function set scale(param1:String) : void
      {
         if(param1 != var_337)
         {
            var_337 = param1;
            refresh();
         }
      }
      
      public function get onlyHead() : Boolean
      {
         return var_938;
      }
      
      public function set onlyHead(param1:Boolean) : void
      {
         if(param1 != var_938)
         {
            var_938 = param1;
            refresh();
         }
      }
      
      public function get cropped() : Boolean
      {
         return _cropped;
      }
      
      public function set cropped(param1:Boolean) : void
      {
         if(param1 != _cropped)
         {
            _cropped = param1;
            refresh();
         }
      }
      
      public function get direction() : int
      {
         return var_81;
      }
      
      public function set direction(param1:int) : void
      {
         if(param1 != var_81)
         {
            var_81 = param1;
            refresh();
         }
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function set userId(param1:int) : void
      {
         if(var_1270 != param1)
         {
            var_1270 = param1;
            var_308.visible = var_1270 > 0;
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(cleanupAvatarString(param1) == var_975)
         {
            refresh();
         }
      }
      
      private function onAvatarRendererReady(param1:Event) : void
      {
         var_2274 = false;
         _windowManager.avatarRenderer.events.removeEventListener("AVATAR_RENDER_READY",onAvatarRendererReady);
         refresh();
      }
      
      private function refresh() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:class_1827 = null;
         var _loc2_:String = null;
         _bitmap.bitmap = null;
         if(_windowManager.avatarRenderer != null)
         {
            if(!_windowManager.avatarRenderer.isReady)
            {
               if(!var_2274)
               {
                  _windowManager.avatarRenderer.events.addEventListener("AVATAR_RENDER_READY",onAvatarRendererReady);
                  var_2274 = true;
               }
            }
            else
            {
               _loc3_ = var_337 == "h" ? 1 : 0.5;
               _loc1_ = _windowManager.avatarRenderer.createAvatarImage(var_975,"h",null,this);
               if(_loc1_ != null)
               {
                  _loc1_.setDirection(var_938 ? "head" : "full",var_81);
                  if(_cropped)
                  {
                     _bitmap.bitmap = _loc1_.getCroppedImage(var_938 ? "head" : "full",_loc3_);
                  }
                  else
                  {
                     _bitmap.bitmap = _loc1_.getImage(var_938 ? "head" : "full",true,_loc3_);
                  }
                  if(var_4523)
                  {
                     greyBitmap(_bitmap);
                  }
                  _bitmap.disposesBitmap = true;
                  _loc1_.dispose();
               }
            }
         }
         if(_bitmap.bitmap == null || _bitmap.bitmap.width < 2)
         {
            _loc2_ = "placeholder_avatar" + (var_337 == "sh" ? "_small" : "") + (var_938 ? "_head" : "") + (_cropped ? "_cropped" : "") + "_png";
            _bitmap.bitmap = _windowManager.assets.getAssetByName(_loc2_).content as BitmapData;
            _bitmap.disposesBitmap = false;
            greyBitmap(_bitmap);
         }
         _bitmap.invalidate();
         var_210.width = _bitmap.bitmap.width;
         var_210.height = _bitmap.bitmap.height;
      }
      
      private function greyBitmap(param1:class_2251) : void
      {
         _bitmap.bitmap.applyFilter(_bitmap.bitmap,_bitmap.bitmap.rect,new Point(),new ColorMatrixFilter([0.3333333333333333,0.3333333333333333,0.3333333333333333,0,0,0.3333333333333333,0.3333333333333333,0.3333333333333333,0,0,0.3333333333333333,0.3333333333333333,0.3333333333333333,0,0,0,0,0,1,0]));
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         if(var_1270 > 0)
         {
            _windowManager.communication.connection.send(new GetExtendedProfileMessageComposer(var_1270));
         }
      }
   }
}

