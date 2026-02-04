package com.sulake.habbo.catalog.clubcenter
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2872;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.window.class_38;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import package_3.class_3429;
   
   public class ClubSpecialInfoBubbleView
   {
      
      private static const MARGIN:int = 8;
      
      private var var_24:class_3429;
      
      private var var_55:HabboClubCenter;
      
      private var _window:class_1812;
      
      private var var_1694:Timer;
      
      public function ClubSpecialInfoBubbleView(param1:HabboClubCenter, param2:class_38, param3:class_3429, param4:class_1741)
      {
         super();
         var_24 = param3;
         var_55 = param1;
         _window = param2.buildFromXML(XML(var_55.assets.getAssetByName("club_center_special_info_xml").content)) as class_1812;
         if(!_window)
         {
            return;
         }
         _window.procedure = onInput;
         positionWindow(param4);
         setElementText("info_creditsspent",getLocalization("hccenter.breakdown.creditsspent").replace("%credits%",var_24.totalCreditsSpent));
         var _loc6_:int = var_24.kickbackPercentage * 100;
         setElementText("info_factor",getLocalization("hccenter.breakdown.paydayfactor").replace("%percent%",_loc6_).replace("%multiplier%",var_24.kickbackPercentage));
         _loc6_ = var_24.kickbackPercentage * 100;
         var _loc5_:String = var_55.localization.getLocalization("hccenter.breakdown.paydayfactor.percent");
         if(_loc5_ && _loc5_.length > 0)
         {
            _loc5_ = _loc5_.replace("%percent%",_loc6_).replace("%multiplier%",var_24.kickbackPercentage);
         }
         else
         {
            _loc5_ = getLocalization("hccenter.breakdown.paydayfactor").replace("%percent%",var_24.kickbackPercentage);
         }
         setElementText("info_factor",_loc5_);
         setElementText("info_streakbonus",getLocalization("hccenter.breakdown.streakbonus").replace("%credits%",var_24.creditRewardForStreakBonus));
         var _loc8_:Number = int((var_24.kickbackPercentage * var_24.totalCreditsSpent + var_24.creditRewardForStreakBonus) * 100) / 100;
         var _loc7_:int = int((var_24.creditRewardForMonthlySpent + var_24.creditRewardForStreakBonus) * 100) / 100;
         setElementText("info_total",getLocalization("hccenter.breakdown.total").replace("%credits%",_loc7_).replace("%actual%",_loc8_));
         _window.activate();
         var_1694 = new Timer(80,1);
         var_1694.addEventListener("timer",onTimerEvent);
         var_1694.start();
         if(var_55.stage)
         {
            var_55.stage.addEventListener("click",onStageClick);
         }
      }
      
      private function onTimerEvent(param1:TimerEvent) : void
      {
         var_1694.stop();
         var_1694.removeEventListener("timer",onTimerEvent);
         var_1694 = null;
         _window.activate();
      }
      
      public function dispose() : void
      {
         if(var_55 && var_55.stage)
         {
            var_55.stage.removeEventListener("click",onStageClick);
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_55 = null;
      }
      
      private function onInput(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_DOWN" || !var_55)
         {
            return;
         }
         param1.stopImmediatePropagation();
         var _loc3_:* = param2.name;
         if("special_infolink" === _loc3_)
         {
            var_55.openPaydayHelpPage();
         }
         var_55.removeBreakdown();
      }
      
      private function onStageClick(param1:MouseEvent) : void
      {
         if(var_55)
         {
            var_55.removeBreakdown();
         }
      }
      
      private function positionWindow(param1:class_1741) : void
      {
         if(!param1 || !_window || !var_55 || !var_55.stage)
         {
            return;
         }
         var _loc2_:Point = new Point();
         param1.getGlobalPosition(_loc2_);
         if(var_55.stage.stageWidth < _loc2_.x + param1.width + _window.width + 8 && _loc2_.x > _window.width + 8)
         {
            (_window as class_2872).direction = "right";
            _loc2_.x -= _window.width + 8;
         }
         else
         {
            _loc2_.x += param1.width + 8;
         }
         _loc2_.y += param1.height * 0.5 - _window.height * 0.5;
         _window.position = _loc2_;
      }
      
      private function setElementText(param1:String, param2:String) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc3_:ITextWindow = _window.findChildByName(param1) as ITextWindow;
         if(_loc3_)
         {
            _loc3_.text = param2;
         }
      }
      
      private function getLocalization(param1:String) : String
      {
         if(!var_55 || !var_55.localization)
         {
            return "";
         }
         return var_55.localization.getLocalization(param1,param1);
      }
   }
}

