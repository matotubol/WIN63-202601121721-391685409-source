package com.sulake.habbo.ui.widget.uihelpbubbles
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.components.class_2872;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class UiHelpBubble
   {
      
      private var _window:class_1812;
      
      private var var_16:UiHelpBubblesWidget;
      
      private var var_197:String;
      
      private var var_3605:Point;
      
      private var var_5014:String;
      
      private var var_3192:Boolean;
      
      private var _bubble:class_2872;
      
      private var var_2557:class_1775;
      
      private var var_298:class_1812;
      
      private var var_5122:Boolean;
      
      private var var_2353:class_2251;
      
      private var var_2813:class_1741;
      
      private var var_4972:class_1741;
      
      private var var_581:Function;
      
      public function UiHelpBubble(param1:UiHelpBubblesWidget, param2:HelpBubbleItem, param3:Boolean)
      {
         super();
         var_16 = param1;
         var_197 = param2.name;
         var_5014 = param2.text;
         var_3192 = param3;
         var_5122 = param2.modal;
         createWindow();
      }
      
      public function dispose() : void
      {
         var_16 = null;
         if(var_2813 != null && var_581 != null)
         {
            var_2813.removeEventListener("WME_CLICK",var_581);
         }
         if(var_298)
         {
            var_298.dispose();
            var_298 = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function addMouseClickListener(param1:class_1741, param2:Function) : void
      {
         if(param1 != null)
         {
            param1.setParamFlag(1,true);
            param1.addEventListener("WME_CLICK",param2);
         }
      }
      
      private function createWindow() : void
      {
         var _loc4_:XmlAsset = null;
         if(!var_16 || !var_16.assets || !var_16.windowManager)
         {
            return;
         }
         if(var_5122)
         {
            _loc4_ = var_16.assets.getAssetByName("ui_help_modal") as XmlAsset;
            var_298 = var_16.windowManager.buildFromXML(_loc4_.content as XML,3) as class_1812;
         }
         if(var_298)
         {
            var_298.width = var_298.desktop.width;
            var_298.height = var_298.desktop.height;
            var_2353 = var_298.findChildByName("bitmap") as class_2251;
            addMouseClickListener(var_2353,onActivateBubble);
         }
         var _loc2_:XmlAsset = var_16.assets.getAssetByName("ui_help_bubble") as XmlAsset;
         if(!_loc2_)
         {
            return;
         }
         _window = var_16.windowManager.buildFromXML(_loc2_.content as XML,3) as class_1812;
         if(!_window)
         {
            return;
         }
         var_2557 = _window.findChildByName("help_bubble_btn_ok") as class_1775;
         _bubble = _window.findChildByName("bubble") as class_2872;
         var _loc3_:ITextWindow = _window.findChildByName("help_bubble_text") as ITextWindow;
         if(_loc3_)
         {
            _loc3_.text = var_5014;
            var _loc1_:int = _loc3_.textHeight;
            _window.height = 0 + 90;
            var_2557.y = 0 + 30;
         }
         if(!var_3192)
         {
            var_2557.caption = var_16.localizations.getLocalization("alert.close.button","alert.close.button");
            addMouseClickListener(var_2557,onLastBubble);
         }
         else
         {
            addMouseClickListener(var_2557,onNext);
         }
         _window.visible = true;
      }
      
      public function show() : void
      {
         if(_window != null)
         {
            _window.visible = true;
            _window.activate();
         }
      }
      
      private function onActivateBubble(param1:WindowMouseEvent) : void
      {
         var_298.deactivate();
         _window.activate();
      }
      
      private function onNext(param1:WindowMouseEvent) : void
      {
         if(!var_16)
         {
            return;
         }
         if(var_298)
         {
            var_298.visible = false;
         }
         var_16.removeHelpBubble(var_197);
      }
      
      private function onLastBubble(param1:WindowMouseEvent) : void
      {
         if(!var_16)
         {
            return;
         }
         var_16.sendScriptProceedMessage();
         if(var_298)
         {
            var_298.visible = false;
         }
         var_16.removeHelpBubble(var_197);
      }
      
      public function setModal(param1:Rectangle) : void
      {
         if(!var_2353)
         {
            return;
         }
         var _loc3_:BitmapData = new BitmapData(var_298.width,var_298.height,true,4292870144);
         var _loc2_:BitmapData = new BitmapData(param1.width,param1.height,true,16777215);
         _loc3_.copyPixels(_loc2_,_loc2_.rect,new Point(param1.x,param1.y));
         var_2353.bitmap = _loc3_;
         var_2353.invalidate();
      }
      
      public function setPosition(param1:Point) : void
      {
         var_3605 = param1;
         _window.y = var_3605.y;
         _window.x = var_3605.x - _window.width / 2;
      }
      
      public function setArrowPos(param1:String, param2:int) : void
      {
         _bubble.direction = param1;
         _bubble.pointerOffset = param2 - 8;
      }
      
      public function setCallback(param1:class_1741) : void
      {
         if(var_581 != null)
         {
            return;
         }
         var_2813 = param1;
         if(!var_3192)
         {
            var_581 = onLastBubble;
         }
         else
         {
            var_581 = onNext;
         }
         var_2813.addEventListener("WME_CLICK",var_581);
      }
      
      public function setChatFieldCallback(param1:ITextFieldWindow) : void
      {
         if(var_581 != null)
         {
            return;
         }
         var_4972 = param1;
         if(!var_3192)
         {
            var_581 = onLastBubble;
         }
         else
         {
            var_581 = onNext;
         }
         var_4972.addEventListener("WME_CLICK",var_581);
      }
      
      public function getWindow() : class_1812
      {
         return _window;
      }
      
      public function getName() : String
      {
         return var_197;
      }
   }
}

