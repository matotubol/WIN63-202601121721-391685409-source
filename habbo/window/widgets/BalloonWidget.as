package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.utils.class_2724;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.enum.class_4052;
   import flash.geom.Rectangle;
   
   public class BalloonWidget implements class_2802
   {
      
      public static const TYPE:String = "balloon";
      
      private static const ARROW_PIVOT_KEY:String = "balloon:arrow_pivot";
      
      private static const ARROW_DISPLACEMENT_KEY:String = "balloon:arrow_displacement";
      
      private static const ARROW_ASSET_PREFIX:String = "illumina_light_balloon_arrow_";
      
      private static const ARROW_FREE_PADDING:int = 6;
      
      private static const ARROW_LENGTH:int = 6;
      
      private static const ARROW_WIDTH:int = 9;
      
      private static const ARROW_PIVOT_DEFAULT:PropertyStruct = new PropertyStruct("balloon:arrow_pivot","up, center","String",false,class_4052.ALL);
      
      private static const ARROW_DISPLACEMENT_DEFAULT:PropertyStruct = new PropertyStruct("balloon:arrow_displacement",0,"int");
      
      private var _disposed:Boolean;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_2758:Boolean = false;
      
      private var var_669:Boolean = false;
      
      private var var_134:class_1812;
      
      private var var_160:class_1812;
      
      private var var_1930:IStaticBitmapWrapperWindow;
      
      private var var_1337:String = String(ARROW_PIVOT_DEFAULT.value);
      
      private var var_1758:int = int(ARROW_DISPLACEMENT_DEFAULT.value);
      
      public function BalloonWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("balloon_xml").content as XML) as class_1812;
         var_1930 = var_134.findChildByName("bitmap") as IStaticBitmapWrapperWindow;
         var_160 = var_134.findChildByName("border") as class_1812;
         syncFlags();
         var_210.addEventListener("WE_RESIZE",onChange);
         var_210.addEventListener("WE_RESIZED",onChange);
         var_160.addEventListener("WE_RESIZE",onChange);
         var_160.addEventListener("WE_RESIZED",onChange);
         var_210.rootWindow = var_134;
         var_134.width = var_210.width;
         var_134.height = var_210.height;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_160 != null)
            {
               var_160.removeEventListener("WE_RESIZE",onChange);
               var_160.removeEventListener("WE_RESIZED",onChange);
               var_160 = null;
            }
            var_1930 = null;
            if(var_134 != null)
            {
               var_134.dispose();
               var_134 = null;
            }
            if(var_210 != null)
            {
               var_210.removeEventListener("WE_RESIZE",onChange);
               var_210.removeEventListener("WE_RESIZED",onChange);
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
         return var_160?.iterator;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(ARROW_PIVOT_DEFAULT.withValue(var_1337));
         _loc1_.push(ARROW_DISPLACEMENT_DEFAULT.withValue(var_1758));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         var_2758 = true;
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "balloon:arrow_pivot":
                  arrowPivot = String(_loc2_.value);
                  break;
               case "balloon:arrow_displacement":
                  arrowDisplacement = int(_loc2_.value);
            }
         }
         var_2758 = false;
         refresh();
      }
      
      public function get arrowPivot() : String
      {
         return var_1337;
      }
      
      public function set arrowPivot(param1:String) : void
      {
         var_1337 = param1;
         clearFlags();
         refresh();
         syncFlags();
         refresh();
      }
      
      public function get arrowDisplacement() : int
      {
         return var_1758;
      }
      
      public function set arrowDisplacement(param1:int) : void
      {
         var_1758 = param1;
         refresh();
      }
      
      private function onChange(param1:class_1758) : void
      {
         refresh();
      }
      
      private function syncFlags() : void
      {
         if(var_160 != null)
         {
            var_160.setParamFlag(131072,var_210.getParamFlag(131072));
            var_160.setParamFlag(147456,var_210.getParamFlag(147456));
         }
      }
      
      private function clearFlags() : void
      {
         if(var_160 != null)
         {
            var_160.setParamFlag(131072,false);
            var_160.setParamFlag(147456,false);
         }
      }
      
      private function refresh() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         if(var_2758 || var_669 || _disposed || var_160 == null)
         {
            return;
         }
         var _loc4_:String;
         switch(_loc4_ = class_4052.directionFromPivot(var_1337))
         {
            case "up":
            case "down":
               _loc1_ = int(var_160.width);
               _loc3_ = var_160.height + 6 - 1;
               break;
            case "left":
            case "right":
               _loc1_ = var_160.width + 6 - 1;
               _loc3_ = int(var_160.height);
         }
         var_669 = true;
         if(var_210.testParamFlag(147456))
         {
            var_134.width = _loc1_;
            var_134.height = _loc3_;
         }
         else if(var_210.testParamFlag(131072))
         {
            var_134.width = Math.max(var_210.width,_loc1_);
            var_134.height = Math.max(var_210.height,_loc3_);
         }
         else
         {
            var_134.width = var_210.width;
            var_134.height = var_210.height;
         }
         var_210.width = var_134.width;
         var_210.height = var_134.height;
         var_669 = false;
         var_1930.assetUri = "illumina_light_balloon_arrow_" + _loc4_;
         switch(_loc4_)
         {
            case "up":
            case "down":
               switch(class_4052.positionFromPivot(var_1337))
               {
                  case "minimum":
                     var _loc2_:int = 6;
                     break;
                  case "middle":
                     _loc2_ = (var_134.width - 9) / 2;
                     break;
                  case "maximum":
                     _loc2_ = var_134.width - 6 - 9;
               }
               var_669 = true;
               var_160.rectangle = new Rectangle(0,_loc4_ == "up" ? 6 - 1 : 0,var_134.width,var_134.height + 1 - 6);
               var_669 = false;
               var_1930.rectangle = new Rectangle(class_2724.clamp(0 + var_1758,6,var_134.width - 6),_loc4_ == "up" ? 0 : var_160.bottom - 1,9,6);
               break;
            case "left":
            case "right":
               switch(class_4052.positionFromPivot(var_1337))
               {
                  case "minimum":
                     _loc2_ = 6;
                     break;
                  case "middle":
                     _loc2_ = (var_134.height - 9) / 2;
                     break;
                  case "maximum":
                     _loc2_ = var_134.height - 6 - 9;
               }
               var_669 = true;
               var_160.rectangle = new Rectangle(_loc4_ == "left" ? 6 - 1 : 0,0,var_134.width + 1 - 6,var_134.height);
               var_669 = false;
               var_1930.rectangle = new Rectangle(_loc4_ == "left" ? 0 : var_160.right - 1,class_2724.clamp(0 + var_1758,6,var_134.height - 6),6,9);
         }
      }
   }
}

