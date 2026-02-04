package com.sulake.habbo.friendbar.onBoardingHc
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import onBoardingHcUi.LoaderUI;
   import onBoardingHcUi.NineSplitSprite;
   import onBoardingHcUi.WaitIndicator;
   
   public class HitchNameChangeDialog extends NameChangeDialog
   {
      
      private var icon_name_ok_png:Class = class_4110;
      
      private var icon_name_alert_png:Class = class_4109;
      
      public function HitchNameChangeDialog(param1:class_3325, param2:Sprite, param3:int)
      {
         super(param1,param2,param3);
      }
      
      override protected function init() : void
      {
         _style = 2;
         var_129 = LoaderUI.createFrame("","",new Rectangle(-_dialogWidth / 2,0,_dialogWidth,1),_style);
         _container.addChild(var_129);
         var _loc5_:int = 0;
         var _loc4_:int = 330;
         var _loc1_:int = _dialogWidth - 12;
         var _loc8_:Boolean = false;
         var _loc2_:Sprite = new Sprite();
         var_250 = NineSplitSprite.INPUT_FIELD_HITCH.render(_loc4_,31);
         _loc2_.addChild(var_250);
         var_129.addChild(_loc2_);
         _loc2_.x = _loc5_;
         var _loc7_:Bitmap = null;
         var _loc3_:TextField = LoaderUI.createTextField(_context.getLocalization("onboarding.characters.tip","TIP: There are tons of Habbos created every day"),18,8309486,false,true,false,false);
         _loc3_.width = _loc4_ - 32;
         var _loc6_:TextField = LoaderUI.createTextField(_context.getLocalization("onboarding.creative.tip","be creative! You can also use these special characters"),18,8309486,false,true,false,false);
         _loc6_.width = _loc4_ - 32;
         var_279 = new Sprite();
         var _loc9_:Bitmap = LoaderUI.createBalloon(295,230,45,false,995918,"down");
         _loc9_.y = 90;
         var_279.addChild(_loc9_);
         var_279.addChild(_loc3_);
         var_279.addChild(_loc6_);
         _loc3_.x = 16;
         _loc3_.y = _loc9_.y + (_loc9_.height - (_loc3_.height + _loc6_.height)) / 2;
         _loc3_.width = 250;
         var_279.visible = false;
         _loc6_.x = 16;
         _loc6_.y = _loc3_.y + _loc3_.height + 20;
         _loc6_.width = 250;
         if(_loc7_ != null)
         {
            var_279.addChild(_loc7_);
            _loc7_.x = 16;
            _loc7_.y = int((var_279.height - _loc7_.height) / 2);
         }
         var_129.addChild(var_279);
         var_279.x = _loc5_;
         _inputDefaultString = _context.getLocalization("name","Enter name here");
         var_33 = LoaderUI.createTextField(_inputDefaultString,18,6710886,true,false,true,false);
         var_129.addChild(var_33);
         var_33.x = _loc2_.x + 16;
         var_33.y = _loc2_.y + int((_loc2_.height - var_33.height) / 2);
         var_33.width = _loc2_.width - 30;
         var_33.addEventListener("click",onInputClicked);
         var_33.addEventListener("change",onInputChange);
         var_334 = new icon_name_ok_png();
         var_129.addChild(var_334);
         var_334.y = _loc2_.y + int((_loc2_.height - var_334.height) / 2);
         var_334.x = _loc2_.x + _loc2_.width - var_334.width - 7;
         var_972 = new icon_name_alert_png();
         var_129.addChild(var_972);
         var_972.x = var_334.x;
         var_972.y = var_334.y;
         nameIsCorrect = false;
         var_259 = new WaitIndicator(_style);
         var_129.addChild(var_259);
         var_259.y = _loc2_.y + int(_loc2_.height / 2) + 2;
         var_259.x = _loc2_.x + _loc2_.width - int(var_334.width / 2) - 7;
         var_259.visible = false;
         _loc2_.addEventListener("click",onInputBackgroundClicked);
         var_129.y = -50;
      }
   }
}

