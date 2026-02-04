package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import flash.geom.Rectangle;
   
   public class TagListRenderer
   {
      
      private const MARGIN_X:int = 5;
      
      private const MARGIN_Y:int = 5;
      
      private var var_16:InfoStandWidget;
      
      private var var_254:Function;
      
      private var _offsetX:int;
      
      private var _offsetY:int;
      
      private var var_2336:Rectangle = null;
      
      private var var_5225:int = 0;
      
      private var var_2933:Array;
      
      public function TagListRenderer(param1:InfoStandWidget, param2:Function)
      {
         super();
         var_16 = param1;
         var_254 = param2;
      }
      
      public function dispose() : void
      {
         var_16 = null;
         var_254 = null;
      }
      
      public function renderTags(param1:Array, param2:class_1812, param3:Array) : int
      {
         var_2933 = param3;
         if(var_2933 != null)
         {
            var _loc4_:Array = [];
            while(true)
            {
               var _loc5_:String = param1.pop();
               if(_loc5_ == null)
               {
                  break;
               }
               param3.indexOf(null) != -1 ? null.unshift(null) : uint(null.push(null));
            }
            param1 = null;
         }
         while(param2.removeChildAt(0) != null)
         {
         }
         var_5225 = 0;
         _offsetX = 0;
         _offsetY = 0;
         var_2336 = param2.rectangle;
         var_2336.height = 150;
         var _loc7_:int = 0;
         while(0 < param1.length)
         {
            var _loc9_:ITextWindow = createTag(param1[0] as String);
            if(fit(null))
            {
               param2.addChild(null);
            }
            else
            {
               null.dispose();
            }
            _loc7_++;
         }
         var _loc8_:int = param2.numChildren;
         if(_loc8_ == 0)
         {
            return 0;
         }
         var _loc6_:class_1741 = param2.getChildAt(param2.numChildren - 1);
         return _loc6_.bottom;
      }
      
      private function fit(param1:class_1741) : Boolean
      {
         if(param1.width > var_2336.width)
         {
            return false;
         }
         if(_offsetY + param1.height > var_2336.height)
         {
            return false;
         }
         if(_offsetX + param1.width > var_2336.width)
         {
            _offsetX = 0;
            _offsetY += param1.height + 5;
            return fit(param1);
         }
         param1.offset(_offsetX,_offsetY);
         _offsetX += param1.width + 5;
         return true;
      }
      
      private function createTag(param1:String) : ITextWindow
      {
         var _loc2_:XmlAsset = null;
         if(var_2933 != null && var_2933.indexOf(param1) != -1)
         {
            _loc2_ = var_16.assets.getAssetByName("user_tag_highlighted") as XmlAsset;
         }
         else
         {
            _loc2_ = var_16.assets.getAssetByName("user_tag") as XmlAsset;
         }
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:ITextWindow = var_16.windowManager.buildFromXML(_loc2_.content as XML) as ITextWindow;
         if(_loc3_ == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _loc3_.addEventListener("WME_CLICK",var_254);
         _loc3_.caption = param1;
         return _loc3_;
      }
   }
}

