package com.sulake.habbo.catalog.collectibles.tabs.subviews
{
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.collectibles.class_2714;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.window.widgets.class_2478;
   import com.sulake.habbo.window.widgets.class_3087;
   import com.sulake.habbo.window.widgets.class_3567;
   import flash.display.BitmapData;
   
   public class CollectibleProductPreviewer implements class_2714
   {
      
      private var var_1824:Number;
      
      private var var_2185:class_2010;
      
      private var var_2159:class_2010;
      
      private var var_1979:class_2010;
      
      private var var_1197:class_2251;
      
      private var var_2293:IStaticBitmapWrapperWindow;
      
      private var var_988:EffectPreviewer;
      
      private var var_2311:IStaticBitmapWrapperWindow;
      
      private var _disposed:Boolean;
      
      public function CollectibleProductPreviewer(param1:class_2251, param2:class_2010, param3:class_2010, param4:IStaticBitmapWrapperWindow, param5:class_2010 = null, param6:IStaticBitmapWrapperWindow = null, param7:class_2010 = null, param8:class_48 = null)
      {
         super();
         var_2185 = param5;
         var_2159 = param2;
         var_1979 = param3;
         var_1197 = param1;
         var_2293 = param6;
         if(param7 != null && param8 != null)
         {
            var_988 = new EffectPreviewer(param7,param8);
         }
         var_2311 = param4;
         clearPreviewer();
      }
      
      public function clearPreviewer() : void
      {
         var_1824 = -1;
         if(var_2185 != null)
         {
            var_2185.visible = false;
         }
         if(var_1197 != null)
         {
            var_1197.visible = false;
         }
         if(var_2159 != null)
         {
            var_2159.visible = false;
         }
         if(var_2293 != null)
         {
            var_2293.visible = false;
         }
         if(var_1979 != null)
         {
            var_1979.visible = false;
         }
         if(var_988 != null)
         {
            var_988.visible = false;
         }
         if(var_2311 != null)
         {
            var_2311.visible = false;
         }
      }
      
      public function set imageResult(param1:class_2198) : void
      {
         clearPreviewer();
         if(!var_1197)
         {
            return;
         }
         if(param1 != null)
         {
            var_1824 = param1.id;
            setPreviewImage(param1.data);
         }
      }
      
      public function set avatarResult(param1:String) : void
      {
         clearPreviewer();
         if(!var_2185)
         {
            return;
         }
         var_2185.visible = true;
         var _loc2_:class_2478 = var_2185.widget as class_2478;
         _loc2_.figure = param1;
      }
      
      public function set badgeResult(param1:String) : void
      {
         clearPreviewer();
         if(!var_2159)
         {
            return;
         }
         var_2159.visible = true;
         var _loc2_:class_3087 = var_2159.widget as class_3087;
         _loc2_.badgeId = param1;
      }
      
      public function set petResult(param1:String) : void
      {
         clearPreviewer();
         if(!var_1979)
         {
            return;
         }
         var_1979.visible = true;
         var _loc2_:class_3567 = var_1979.widget as class_3567;
         _loc2_.figure = param1;
      }
      
      public function setEffectResult(param1:String, param2:int) : void
      {
         clearPreviewer();
         if(!var_988)
         {
            return;
         }
         var_988.visible = true;
         var_988.update(param1,param2);
      }
      
      public function setUnknownImage() : void
      {
         clearPreviewer();
         if(!var_2311)
         {
            return;
         }
         var_2311.visible = true;
      }
      
      public function setPlaceholder() : void
      {
         clearPreviewer();
         if(!var_2293)
         {
            return;
         }
         var_2293.visible = true;
      }
      
      private function setPreviewImage(param1:BitmapData) : void
      {
         if(var_1197 == null)
         {
            return;
         }
         if(param1 == null)
         {
            var_1197.visible = false;
            return;
         }
         var_1197.bitmap = param1.clone();
         var_1197.visible = true;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(var_1824 == param1 && var_1197 != null)
         {
            setPreviewImage(param2);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_988 != null)
         {
            var_988.dispose();
            var_988 = null;
         }
         var_1824 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

