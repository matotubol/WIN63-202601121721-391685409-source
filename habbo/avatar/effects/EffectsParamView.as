package com.sulake.habbo.avatar.effects
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.class_2972;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class EffectsParamView implements class_13
   {
      
      private var var_36:EffectsModel;
      
      private var _container:class_1812;
      
      private var _catalogPageName:String;
      
      private var _windowManager:class_38;
      
      private var var_1054:Timer;
      
      private var var_2956:int = 0;
      
      private var var_2653:class_2972 = null;
      
      public function EffectsParamView(param1:EffectsModel, param2:class_38, param3:class_40)
      {
         super();
         var_36 = param1;
         _windowManager = param2;
         _container = param1.controller.view.effectsParamViewContainer;
         _catalogPageName = param1.controller.manager.getProperty("avatareditor.effects.buy.button.catalog.page.name");
         var_1054 = new Timer(1000);
         var_1054.addEventListener("timer",onSecondsTimer);
         _container.findChildByName("get_more_button").addEventListener("WME_CLICK",onBuyButtonClick);
         updateView(null);
      }
      
      public function dispose() : void
      {
         if(var_1054)
         {
            var_1054.stop();
            var_1054.removeEventListener("timer",onSecondsTimer);
            var_1054 = null;
         }
         _windowManager = null;
         var_36 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_36 == null;
      }
      
      public function updateView(param1:class_2972) : void
      {
         var_2653 = param1;
         _container.visible = true;
         if(param1 == null)
         {
            _container.findChildByName("time_left_bg").visible = false;
            _container.findChildByName("save_to_activate").visible = false;
            _container.findChildByName("effect_name").visible = false;
         }
         else
         {
            _container.findChildByName("effect_name").visible = true;
            if(!param1.isActive && !param1.isPermanent)
            {
               _container.findChildByName("time_left_bg").visible = false;
               _container.findChildByName("save_to_activate").visible = true;
               var_1054.stop();
            }
            else
            {
               var_2956 = param1.secondsLeft;
               setSecondsLeft(param1.secondsLeft,param1.duration,param1.isPermanent);
               _container.findChildByName("time_left_bg").visible = true;
               _container.findChildByName("save_to_activate").visible = false;
               var_1054.start();
            }
            _container.findChildByName("effect_name").caption = "${fx_" + param1.type + "}";
         }
      }
      
      private function setSecondsLeft(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc17_:String = null;
         var _loc16_:int = 0;
         var _loc18_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc13_:int = 0;
         var _loc10_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc5_:class_1812 = _container.findChildByName("time_left_bg") as class_1812;
         var _loc12_:class_2251 = class_2251(_loc5_.findChildByName("progress_bar_bitmap"));
         var _loc6_:BitmapData = new BitmapData(_loc12_.width,_loc12_.height,false,0);
         var _loc4_:int = param3 ? param2 : param1;
         var _loc8_:Rectangle = new Rectangle(0,0,int(_loc6_.width * (_loc4_ / param2)),_loc6_.height);
         _loc6_.fillRect(_loc8_,2146080);
         _loc12_.bitmap = _loc6_;
         var _loc11_:ITextWindow = ITextWindow(_loc5_.findChildByName("effect_time_left"));
         if(param3)
         {
            _loc11_.caption = "${avatareditor.effects.active.permanent}";
            _loc17_ = _loc11_.text;
         }
         else if(param1 > 86400)
         {
            _loc11_.caption = "${avatareditor.effects.active.daysleft}";
            _loc17_ = _loc11_.text;
            _loc16_ = Math.floor(param1 / 86400);
            _loc17_ = _loc17_.replace("%days_left%",_loc16_);
         }
         else
         {
            _loc11_.caption = "${avatareditor.effects.active.timeleft}";
            _loc17_ = _loc11_.text;
            _loc18_ = param1;
            _loc7_ = Math.floor(_loc18_ / 3600);
            _loc9_ = Math.floor(_loc18_ / 60) % 60;
            _loc13_ = _loc18_ % 60;
            _loc10_ = _loc7_ < 10 ? "0" : "";
            _loc14_ = _loc9_ < 10 ? "0" : "";
            _loc15_ = _loc13_ < 10 ? "0" : "";
            if(_loc7_ > 0)
            {
               _loc17_ = _loc17_.replace("%time_left%",_loc10_ + _loc7_ + ":" + _loc14_ + _loc9_ + ":" + _loc15_ + _loc13_);
            }
            else
            {
               _loc17_ = _loc17_.replace("%time_left%",_loc14_ + _loc9_ + ":" + _loc15_ + _loc13_);
            }
         }
         _loc11_.text = _loc17_;
      }
      
      private function onBuyButtonClick(param1:WindowMouseEvent) : void
      {
         var_36.controller.manager.catalog.openCatalogPage(_catalogPageName);
      }
      
      private function onSecondsTimer(param1:TimerEvent) : void
      {
         if(var_2653 != null && var_2653.isActive)
         {
            setSecondsLeft(var_2956--,var_2653.duration,var_2653.isPermanent);
         }
      }
   }
}

