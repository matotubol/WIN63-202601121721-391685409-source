package com.sulake.habbo.ui.widget.effects
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.widget.memenu.class_2303;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class EffectView
   {
      
      private const UPDATE_TIMER_MS:int = 1000;
      
      private var var_16:EffectsWidget;
      
      private var _window:class_1812;
      
      private var var_205:class_2303;
      
      private var _bar:class_1741;
      
      private var _maxWidth:Number;
      
      private var var_609:ITextWindow;
      
      private var var_323:Timer;
      
      private var _hilite:class_1741;
      
      public function EffectView(param1:EffectsWidget, param2:class_2303)
      {
         super();
         var_205 = param2;
         var_16 = param1;
         var_323 = new Timer(1000);
         var_323.addEventListener("timer",onUpdate);
         update();
      }
      
      public function get effect() : class_2303
      {
         return var_205;
      }
      
      public function dispose() : void
      {
         if(var_323 != null)
         {
            var_323.stop();
            var_323.removeEventListener("timer",onUpdate);
            var_323 = null;
         }
         var_16 = null;
         var_205 = null;
         _bar = null;
         var_609 = null;
         _hilite = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      private function onUpdate(param1:Event = null) : void
      {
         var _loc2_:Number = NaN;
         if(_bar == null)
         {
            var_323.stop();
            return;
         }
         if(var_205.isActive)
         {
            _loc2_ = var_205.secondsLeft / var_205.duration;
            _bar.width = _loc2_ * _maxWidth;
         }
         else
         {
            _bar.width = 0;
            var_323.stop();
         }
         setTimeLeft();
      }
      
      private function setTimeLeft() : void
      {
         var _loc8_:String = null;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         if(var_609 == null)
         {
            var_609 = _window.findChildByName("time_left") as ITextWindow;
            if(var_609 == null)
            {
               return;
            }
         }
         if(!var_205.isActive)
         {
            var_609.caption = "${widgets.memenu.effects.activate}";
            return;
         }
         if(var_205.secondsLeft > 86400)
         {
            var_609.caption = "${widgets.memenu.effects.active.daysleft}";
            _loc8_ = var_609.text;
            _loc7_ = Math.floor(var_205.secondsLeft / 86400);
            _loc8_ = _loc8_.replace("%days_left%",_loc7_);
         }
         else
         {
            var_609.caption = "${widgets.memenu.effects.active.timeleft}";
            _loc8_ = var_609.text;
            _loc9_ = var_205.secondsLeft;
            _loc1_ = Math.floor(_loc9_ / 3600);
            _loc3_ = Math.floor(_loc9_ / 60) % 60;
            _loc2_ = _loc9_ % 60;
            _loc5_ = _loc1_ < 10 ? "0" : "";
            _loc4_ = _loc3_ < 10 ? "0" : "";
            _loc6_ = _loc2_ < 10 ? "0" : "";
            if(_loc1_ > 0)
            {
               _loc8_ = _loc8_.replace("%time_left%",_loc5_ + _loc1_ + ":" + _loc4_ + _loc3_ + ":" + _loc6_ + _loc2_);
            }
            else
            {
               _loc8_ = _loc8_.replace("%time_left%",_loc4_ + _loc3_ + ":" + _loc6_ + _loc2_);
            }
         }
         var_609.text = _loc8_;
      }
      
      public function update() : void
      {
         var _loc7_:class_1741 = null;
         if(!_window)
         {
            _window = var_16.windowManager.createWindow("","",4,0,16) as class_1812;
         }
         while(_window.numChildren > 0)
         {
            _loc7_ = _window.removeChildAt(0);
            _loc7_.dispose();
         }
         _bar = null;
         _hilite = null;
         var_609 = null;
         var _loc2_:String = "";
         if(var_205.isInUse)
         {
            _loc2_ = "memenu_effect_selected";
         }
         else if(var_205.isActive)
         {
            _loc2_ = "memenu_effect_unselected";
         }
         else
         {
            _loc2_ = "memenu_effect_inactive";
         }
         var _loc5_:XmlAsset = var_16.assets.getAssetByName(_loc2_) as XmlAsset;
         var _loc6_:class_1812 = var_16.windowManager.buildFromXML(null.content as XML) as class_1812;
         _window.addChild(_loc6_);
         var _loc3_:ITextWindow = _window.findChildByName("effect_name") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.caption = "${fx_" + var_205.type + "}";
         }
         var _loc8_:ITextWindow = _window.findChildByName("effect_amount") as ITextWindow;
         if(_loc8_ != null)
         {
            _loc8_.caption = var_205.amountInInventory + "";
         }
         var _loc1_:class_1812 = _window.findChildByName("effect_amount_bg1") as class_1812;
         if(var_205.amountInInventory < 2)
         {
            if(_loc1_ != null)
            {
               _loc1_.visible = false;
            }
         }
         if(_loc2_ == "memenu_effect_inactive")
         {
            var _loc4_:class_1775 = _window.findChildByName("activate_effect") as class_1775;
            if(_loc4_ != null)
            {
               null.addEventListener("WME_CLICK",onMouseEvent);
            }
         }
         else
         {
            _loc6_.addEventListener("WME_CLICK",onMouseEvent);
            if(var_205.isActive)
            {
               _loc6_.addEventListener("WME_OVER",onMouseEvent);
               _loc6_.addEventListener("WME_OUT",onMouseEvent);
            }
            if(var_205.isInUse)
            {
               setElementImage("effect_hilite","memenu_fx_pause");
            }
            else
            {
               setElementImage("effect_hilite","memenu_fx_play");
            }
            _hilite = _window.findChildByName("effect_hilite");
            _hilite.visible = false;
         }
         setTimeLeft();
         _bar = _window.findChildByName("loader_bar");
         if(_bar != null)
         {
            _maxWidth = _bar.width;
            var_323.start();
            onUpdate();
         }
         if(var_205.icon)
         {
            setElementBitmap("effect_icon",var_205.icon);
         }
         _window.rectangle = _loc6_.rectangle;
      }
      
      private function setElementBitmap(param1:String, param2:BitmapData) : void
      {
         var _loc3_:class_2251 = _window.findChildByName(param1) as class_2251;
         if(_loc3_ != null)
         {
            if(_loc3_.bitmap)
            {
               _loc3_.bitmap.dispose();
            }
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _loc3_.bitmap.copyPixels(param2,param2.rect,new Point(0,0));
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         switch(param1.type)
         {
            case "WME_OVER":
               if(_hilite != null)
               {
                  _hilite.visible = true;
               }
               break;
            case "WME_OUT":
               if(_hilite != null)
               {
                  _hilite.visible = false;
               }
               break;
            case "WME_CLICK":
               var_16.selectEffect(var_205.type,var_205.isInUse);
         }
      }
      
      private function setElementImage(param1:String, param2:String) : void
      {
         var _loc4_:BitmapDataAsset = var_16.assets.getAssetByName(param2) as BitmapDataAsset;
         var _loc3_:BitmapData = _loc4_.content as BitmapData;
         setElementBitmap(param1,_loc3_);
      }
   }
}

