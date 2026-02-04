package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import package_115.Game2ExitGameMessageComposer;
   
   public class SnowWarUI implements class_13, class_259
   {
      
      private static const EMPTY_AMMO_FLASH_FRAMES:int = 4;
      
      private static const EMPTY_AMMO_FRAME_LENGTH:int = 75;
      
      private static const SCORE_FLASH_FRAMES:int = 4;
      
      private static const SCORE_FRAME_LENGTH:int = 50;
      
      private static const MAX_SNOWBALLS:int = 5;
      
      private static const MAX_ENERGY:int = 5;
      
      private var var_49:SnowWarEngine;
      
      private var var_1389:class_1812;
      
      private var _snowballs:class_1812;
      
      private var var_633:class_1812;
      
      private var var_323:class_1812;
      
      private var var_810:class_1812;
      
      private var var_684:class_1812;
      
      private var _checksumIndicatorColor:RGBColor;
      
      private var _tweenColor:RGBColor;
      
      private var var_268:class_2251;
      
      private var var_1134:Boolean = false;
      
      private var var_1572:int = 1;
      
      private var _timeSinceLastUpdate:uint;
      
      private var var_4461:int = -1;
      
      private var var_3296:int = 5;
      
      private var var_2720:class_2251;
      
      private var _makingSnowballs:Boolean = false;
      
      private var var_4115:int = 5;
      
      private var var_2166:class_2251;
      
      private var var_995:SnowWarAnimatedWindowElement;
      
      private var _emptyAmmoFlash:class_2251;
      
      private var _emptyAmmoAnimation:SnowWarAnimatedWindowElement;
      
      private var var_2131:class_2251;
      
      private var var_1330:int = 0;
      
      private var _scoreBackgroundAsset:String = "";
      
      private var var_1014:Timer;
      
      private var var_2636:Boolean;
      
      public function SnowWarUI(param1:SnowWarEngine)
      {
         super();
         var_49 = param1;
         var_49.windowManager.getDesktop(1).visible = false;
         var_2636 = var_49.sessionDataManager.hasSecurity(4);
         if(var_2636)
         {
            _checksumIndicatorColor = new RGBColor();
            _tweenColor = new RGBColor(16777215);
         }
      }
      
      public function dispose() : void
      {
         var_49.windowManager.getDesktop(1).visible = true;
         var_49 = null;
         if(var_1389)
         {
            var_1389.dispose();
            var_1389 = null;
         }
         if(_snowballs)
         {
            var_2720 = null;
            var_2166 = null;
            _emptyAmmoFlash = null;
            _snowballs.dispose();
            _snowballs = null;
         }
         if(var_633)
         {
            var_2131 = null;
            var_633.dispose();
            var_633 = null;
         }
         if(var_323)
         {
            var_323.dispose();
            var_323 = null;
         }
         if(var_810)
         {
            var_810.dispose();
            var_810 = null;
         }
         if(var_268)
         {
            var_268.dispose();
            var_268 = null;
         }
         if(_emptyAmmoAnimation != null)
         {
            _emptyAmmoAnimation.dispose();
            _emptyAmmoAnimation = null;
         }
         if(var_684)
         {
            var_684.dispose();
            var_684 = null;
         }
         if(var_1014)
         {
            var_1014.removeEventListener("timerComplete",onTimerHider);
            var_1014.stop();
            var_1014 = null;
         }
         disposeLoadIcon();
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function init() : void
      {
         var_1389 = WindowUtils.createWindow("snowwar_exit") as class_1812;
         var_1389.addEventListener("WME_CLICK",onExit);
         var_1389.x = 0;
         var_1389.y = 10;
         _snowballs = WindowUtils.createWindow("snowwar_snowballs") as class_1812;
         var _loc1_:class_1741 = _snowballs.findChildByName("make_snowball");
         _loc1_.addEventListener("WME_DOWN",onMakeSnowballDown);
         _loc1_.addEventListener("WME_UP",onMakeSnowballUp);
         _loc1_.addEventListener("WME_OUT",onMakeSnowballUp);
         _snowballs.center();
         _snowballs.x = 10;
         var_2720 = _snowballs.findChildByName("makeSnowballImage") as class_2251;
         _emptyAmmoFlash = _snowballs.findChildByName("emptyFlashImage") as class_2251;
         _emptyAmmoFlash.visible = false;
         _emptyAmmoAnimation = new SnowWarAnimatedWindowElement(var_49.assets,_emptyAmmoFlash,"ui_no_balls_",4,75,true);
         var_2166 = _snowballs.findChildByName("ballProgress") as class_2251;
         var_633 = WindowUtils.createWindow("snowwar_own_stats") as class_1812;
         var_633.x = 10;
         var_633.y = var_633.desktop.height - var_633.height - 10;
         var_2131 = var_633.findChildByName("backgroundFlashImage") as class_2251;
         updateUserImage();
         var_810 = WindowUtils.createWindow("snowwar_team_scores") as class_1812;
         var_810.x = var_810.desktop.width - var_810.width - 10;
         var_810.y = 10;
         var_323 = WindowUtils.createWindow("snowwar_timer") as class_1812;
         var_323.x = var_323.desktop.width - var_323.width - 50;
         var_323.y = 105;
         timer = 0;
         var_268 = WindowUtils.createWindow("counter") as class_2251;
         var_268.center();
         if(var_2636)
         {
            var_323.getChildByName("checksumIndicator").visible = true;
            _checksumIndicatorColor.fromInt(var_323.color);
         }
         var_3296 = 5;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         updateUserImage();
      }
      
      private function updateUserImage() : void
      {
         var _loc1_:BitmapData = null;
         var _loc3_:String = var_49.sessionDataManager.figure;
         var _loc2_:String = var_49.sessionDataManager.gender;
         var _loc4_:class_1827 = var_49.avatarManager.createAvatarImage(_loc3_,"h",_loc2_,this);
         if(_loc4_ != null)
         {
            _loc4_.setDirection("full",2);
            _loc1_ = _loc4_.getCroppedImage("head");
            _loc4_.dispose();
            WindowUtils.setElementImage(var_633.findChildByName("user_image"),_loc1_);
            _loc1_.dispose();
         }
      }
      
      private function getBitmap(param1:String) : BitmapData
      {
         return var_49.assets.getAssetByName(param1).content as BitmapData;
      }
      
      private function getElement(param1:class_1812, param2:String) : class_1741
      {
         return param1.findChildByName(param2);
      }
      
      private function onMakeSnowballDown(param1:WindowMouseEvent) : void
      {
         makeSnowballButtonPressed(true);
         if(var_49.makeSnowball())
         {
            startWaitingForSnowball();
         }
      }
      
      private function onMakeSnowballUp(param1:WindowMouseEvent) : void
      {
         makeSnowballButtonPressed(false);
      }
      
      public function startWaitingForSnowball() : void
      {
         if(var_995 != null)
         {
            var_995.dispose();
            var_995 = null;
         }
         var_995 = new SnowWarAnimatedWindowElement(var_49.assets,var_2166,"load_",8);
         SnowWarEngine.playSound("HBSTG_snowwar_make_snowball");
      }
      
      public function stopWaitingForSnowball() : void
      {
         disposeLoadIcon();
         SnowWarEngine.stopSound("HBSTG_snowwar_make_snowball");
         if(_makingSnowballs)
         {
            onMakeSnowballDown(null);
         }
      }
      
      private function disposeLoadIcon() : void
      {
         if(var_995 != null)
         {
            var_995.dispose();
            var_995 = null;
         }
      }
      
      private function onExit(param1:WindowMouseEvent) : void
      {
         if(!var_684)
         {
            var_684 = WindowUtils.createWindow("snowwar_exit_confirmation") as class_1812;
            var_684.findChildByName("yes").addEventListener("WME_CLICK",confirmationHandler);
            var_684.findChildByName("no").addEventListener("WME_CLICK",confirmationHandler);
            var_684.findChildByTag("close").addEventListener("WME_CLICK",confirmationHandler);
         }
         else
         {
            var_684.visible = true;
            var_684.activate();
         }
      }
      
      private function confirmationHandler(param1:WindowMouseEvent) : void
      {
         if(param1.window.name == "yes")
         {
            var_49.send(new Game2ExitGameMessageComposer());
            var_49.resetGameSession();
            var_49.resetRoomSession();
         }
         else
         {
            var_684.visible = false;
         }
      }
      
      public function set snowballs(param1:int) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _snowballs.findChildByName("ball_" + _loc3_).visible = _loc3_ < param1;
            _loc3_++;
         }
         var_4115 = param1;
         var _loc2_:class_1741 = _snowballs.findChildByName("ball_" + param1);
         if(_loc2_ != null)
         {
            var_2166.x = _loc2_.x;
            var_2166.y = _loc2_.y;
         }
      }
      
      public function set ownScore(param1:int) : void
      {
         WindowUtils.setCaption(var_633.findChildByName("personal_score"),param1.toString());
      }
      
      public function set timer(param1:int) : void
      {
         if(var_2636)
         {
            if(_checksumIndicatorColor)
            {
               _checksumIndicatorColor.tweenTo(_tweenColor);
               var_323.getChildByName("checksumIndicator").color = _checksumIndicatorColor.rgb;
            }
         }
         if(var_4461 == param1)
         {
            return;
         }
         var_4461 = param1;
         var _loc2_:String = "" + int(param1 / 60);
         var _loc3_:String = "" + int(param1 % 60);
         if(int(_loc2_) < 10)
         {
            _loc2_ = "0" + _loc2_;
         }
         if(int(_loc3_) < 10)
         {
            _loc3_ = "0" + _loc3_;
         }
         WindowUtils.showElement(var_323,"time_left");
         WindowUtils.setCaption(var_323.findChildByName("time_left"),_loc2_ + ":" + _loc3_);
         if(param1 <= 5 && param1 > 0)
         {
            SnowWarEngine.playSound("HBST_call_for_help");
            if(!var_1014)
            {
               var_1014 = new Timer(500,1);
               var_1014.addEventListener("timerComplete",onTimerHider);
            }
            var_1014.reset();
            var_1014.start();
         }
      }
      
      private function onTimerHider(param1:TimerEvent) : void
      {
         if(var_323)
         {
            WindowUtils.hideElement(var_323,"time_left");
         }
      }
      
      public function set hitPoints(param1:int) : void
      {
         if(var_3296 != param1)
         {
            WindowUtils.setElementImage(getElement(var_633,"energy_bar"),getBitmap("ui_me_health_" + Math.min(5,param1)));
            var_3296 = param1;
         }
      }
      
      public function showChecksumError(param1:uint) : void
      {
         if(var_2636)
         {
            var_323.color = param1;
            if(_checksumIndicatorColor)
            {
               _checksumIndicatorColor.fromInt(param1);
            }
         }
      }
      
      public function initCounter() : void
      {
         _timeSinceLastUpdate = 0;
         var_1572 = 1;
      }
      
      public function update(param1:uint) : void
      {
         updateAmmoDisplay();
         updateCounterImage(param1);
         updateScoreFlash(param1);
         updateTeamScores();
      }
      
      private function updateScoreFlash(param1:uint) : void
      {
         var _loc2_:int = 0;
         if(var_1330 > 0)
         {
            _loc2_ = var_1330 / 50 + 1;
            if(_loc2_ > 4)
            {
               var_1330 = 0;
               var_2131.visible = false;
            }
            else
            {
               var_1330 += param1;
               var_2131.visible = true;
               WindowUtils.setElementImage(var_2131,getBitmap(_scoreBackgroundAsset + _loc2_));
            }
         }
      }
      
      public function flashOwnScore(param1:Boolean) : void
      {
         var_1330 = 1;
         _scoreBackgroundAsset = param1 ? "ui_me_plus_" : "ui_me_minus_";
      }
      
      private function updateAmmoDisplay() : void
      {
         _emptyAmmoFlash.visible = var_4115 == 0 && var_995 == null;
      }
      
      private function updateCounterImage(param1:uint) : void
      {
         var _loc2_:BitmapData = null;
         var _loc3_:Point = null;
         var _loc5_:Boolean = false;
         _timeSinceLastUpdate += param1;
         if(var_1572 < 6)
         {
            if(_timeSinceLastUpdate >= 1000)
            {
               _loc5_ = true;
               _timeSinceLastUpdate = 0;
            }
         }
         else if(var_1572 < 11)
         {
            if(_timeSinceLastUpdate > 100)
            {
               _loc5_ = true;
               _timeSinceLastUpdate = 0;
            }
         }
         else if(var_268)
         {
            var_268.dispose();
            var_268 = null;
         }
         if(!_loc5_ || var_1134 || !var_268)
         {
            return;
         }
         var _loc4_:BitmapDataAsset = var_49.assets.getAssetByName(padName("explosion",var_1572)) as BitmapDataAsset;
         if(_loc4_)
         {
            _loc2_ = _loc4_.content as BitmapData;
            if(!var_268.bitmap)
            {
               var_268.bitmap = new BitmapData(var_268.width,var_268.height,true,16777215);
            }
            var_268.bitmap.fillRect(var_268.bitmap.rect,16777215);
            _loc3_ = new Point(-_loc4_.offset.x,-_loc4_.offset.y);
            var_268.bitmap.copyPixels(_loc2_,_loc2_.rect,_loc3_,null,null,true);
            var_268.invalidate();
         }
         var_1572 = var_1572 + 1;
      }
      
      private function padName(param1:String, param2:int, param3:int = 4) : String
      {
         var _loc4_:String = param2.toString();
         while(_loc4_.length < param3)
         {
            _loc4_ = "0" + _loc4_;
         }
         return param1 + _loc4_;
      }
      
      private function updateTeamScores() : void
      {
         var _loc1_:Array = var_49.gameArena.getTeamScores();
         if(_loc1_.length >= 2)
         {
            WindowUtils.setCaption(var_810.findChildByName("score_blue"),_loc1_[0]);
            WindowUtils.setCaption(var_810.findChildByName("score_red"),_loc1_[1]);
         }
      }
      
      private function makeSnowballButtonPressed(param1:Boolean) : void
      {
         if(_makingSnowballs != param1)
         {
            WindowUtils.setElementImage(var_2720,getBitmap("ui_make_balls_" + (param1 ? "down" : "up")));
         }
         _makingSnowballs = param1;
      }
   }
}

class RGBColor
{
   
   private var _r:uint;
   
   private var _g:uint;
   
   private var _b:uint;
   
   private var _a:uint;
   
   public function RGBColor(param1:uint = 0)
   {
      super();
      fromInt(param1);
   }
   
   public function get r() : uint
   {
      return _r;
   }
   
   public function get g() : uint
   {
      return _g;
   }
   
   public function get b() : uint
   {
      return _b;
   }
   
   public function get a() : uint
   {
      return _a;
   }
   
   public function fromInt(param1:uint) : void
   {
      _a = param1 >> 24 & 0xFF;
      _r = param1 >> 16 & 0xFF;
      _g = param1 >> 8 & 0xFF;
      _b = param1 >> 0 & 0xFF;
   }
   
   public function get rgb() : uint
   {
      return _a << 24 | _r << 16 | _g << 8 | _b;
   }
   
   public function tweenTo(param1:RGBColor) : void
   {
      _a += (param1.a - a) / 24;
      _r += (param1.r - r) / 24;
      _g += (param1.g - g) / 24;
      _b += (param1.b - b) / 24;
   }
}
