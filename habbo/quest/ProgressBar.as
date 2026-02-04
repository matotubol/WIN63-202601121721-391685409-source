package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import flash.geom.Point;
   
   public class ProgressBar implements class_13
   {
      
      private static const PROGRESS_TEXT_X_OFFSET:int = 3;
      
      private static const CONTAINER_SPACING:int = 10;
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:class_1812;
      
      private var _progressBarWidth:int;
      
      private var _progressKey:String;
      
      private var _hasFrame:Boolean;
      
      private var _currentAmount:int;
      
      private var _maxAmount:int;
      
      private var var_3134:int;
      
      private var var_4012:int;
      
      private var _startProgressWidth:int;
      
      private var _currentProgressWidth:int;
      
      private var var_2173:Boolean;
      
      private var var_5100:Boolean;
      
      public function ProgressBar(param1:HabboQuestEngine, param2:class_1812, param3:int, param4:String, param5:Boolean, param6:Point, param7:Boolean = false)
      {
         super();
         _questEngine = param1;
         _window = param2;
         _progressBarWidth = param3;
         _progressKey = param4;
         _hasFrame = param5;
         var_5100 = param7;
         var _loc8_:class_1812 = class_1812(_window.findChildByName("progress_bar_cont"));
         if(_loc8_ == null)
         {
            _loc8_ = class_1812(_questEngine.getXmlWindow("ProgressBar"));
            _window.addChild(_loc8_);
            _loc8_.x = param6.x;
            _loc8_.y = param6.y;
            _loc8_.width = _progressBarWidth + 10;
         }
      }
      
      public function refresh(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:Boolean = param3 != var_4012 || param2 != _maxAmount;
         _maxAmount = param2;
         _currentAmount = param1;
         _startProgressWidth = _currentProgressWidth;
         var_4012 = param3;
         var_3134 = param4;
         if(_loc5_)
         {
            _currentProgressWidth = getProgressWidth(_currentAmount);
         }
         var_2173 = true;
         updateView();
      }
      
      public function set visible(param1:Boolean) : void
      {
         var _loc2_:class_1812 = class_1812(_window.findChildByName("progress_bar_cont"));
         if(_loc2_ != null)
         {
            _loc2_.visible = param1;
         }
      }
      
      public function updateView(param1:uint = 0) : void
      {
         var _loc4_:Number = NaN;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         if(!var_2173)
         {
            return;
         }
         var _loc12_:class_1741 = _window.findChildByName("bar_a_bkg");
         var _loc14_:class_1741 = _window.findChildByName("bar_a_c");
         var _loc13_:class_1741 = _window.findChildByName("bar_a_r");
         var _loc6_:class_1741 = _window.findChildByName("bar_l");
         var _loc2_:class_1741 = _window.findChildByName("bar_c");
         var _loc3_:class_1741 = _window.findChildByName("bar_r");
         _loc6_.visible = _hasFrame;
         _loc2_.visible = _hasFrame;
         _loc3_.visible = _hasFrame;
         if(_hasFrame)
         {
            _loc2_.width = _progressBarWidth;
            _loc3_.x = _progressBarWidth + _loc14_.x;
         }
         var _loc9_:int = getProgressWidth(_currentAmount);
         if(_currentProgressWidth != _loc9_)
         {
            _loc4_ = param1 / 32;
            _loc7_ = _loc9_ - _currentProgressWidth;
            _loc5_ = Math.max(1,_loc4_ * Math.round(Math.sqrt(Math.abs(_loc7_))));
            if(_currentProgressWidth < _loc9_)
            {
               _currentProgressWidth = Math.min(_loc9_,_currentProgressWidth + _loc5_);
            }
            else
            {
               _currentProgressWidth = Math.max(_loc9_,_currentProgressWidth - _loc5_);
            }
         }
         var _loc8_:* = _currentProgressWidth >= 0;
         _loc12_.visible = _loc8_;
         _loc14_.visible = _loc8_;
         _loc13_.visible = _loc8_;
         if(_loc8_)
         {
            _loc14_.blend = 1 - (_loc9_ - _currentProgressWidth) / (_loc9_ - _startProgressWidth);
            _loc14_.width = _currentProgressWidth;
            _loc13_.x = _currentProgressWidth + _loc14_.x;
            _loc12_.width = _loc13_.right - _loc14_.left;
         }
         var_2173 = _currentProgressWidth != _loc9_;
         var _loc11_:class_1741 = _window.findChildByName("progress_txt");
         var _loc10_:int = int(var_2173 ? Math.round(_currentProgressWidth / _progressBarWidth * _maxAmount) : _currentAmount);
         if(var_5100)
         {
            _questEngine.localization.registerParameter(_progressKey,"progress","" + int(Math.floor(_loc10_ * 1 / _maxAmount * 100)));
         }
         else
         {
            _questEngine.localization.registerParameter(_progressKey,"progress","" + (_loc10_ + var_3134));
            _questEngine.localization.registerParameter(_progressKey,"limit","" + (_maxAmount + var_3134));
         }
         _loc11_.caption = _questEngine.localization.getLocalization(_progressKey,_progressKey);
         _loc11_.x = 3 + _loc14_.x + (_progressBarWidth - _loc11_.width) / 2;
      }
      
      public function dispose() : void
      {
         _questEngine = null;
         _window = null;
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function get isUpdating() : Boolean
      {
         return var_2173;
      }
      
      private function getProgressWidth(param1:int) : int
      {
         return Math.max(0,Math.round(_progressBarWidth * param1 / _maxAmount));
      }
   }
}

