package com.sulake.habbo.friendbar.onBoardingHc
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.Timer;
   import onBoardingHcUi.Button;
   import onBoardingHcUi.Dimmer;
   import onBoardingHcUi.LoaderUI;
   import onBoardingHcUi.NineSplitSprite;
   import onBoardingHcUi.WaitIndicator;
   import package_128.class_2461;
   import package_128.class_2679;
   import package_22.class_1789;
   import package_22.class_2414;
   import package_24.class_1886;
   import package_24.class_3130;
   
   public class NameChangeDialog implements class_13
   {
      
      private static const IDLE_TIME_MS:int = 500;
      
      private var input_error_alert_hitch_png:Class = class_4111;
      
      protected var _style:int = 1;
      
      private var _disposed:Boolean;
      
      protected var _context:class_3325;
      
      private var var_4803:Boolean;
      
      protected var var_129:Sprite;
      
      private var var_2649:Dimmer;
      
      protected var var_33:TextField;
      
      protected var _submitButton:Button;
      
      protected var _skipButton:Button;
      
      private var var_257:Sprite;
      
      protected var var_334:Bitmap;
      
      protected var var_972:Bitmap;
      
      private var _inputClickedAlready:Boolean;
      
      protected var var_250:Bitmap;
      
      private var var_804:Timer;
      
      protected var var_259:WaitIndicator;
      
      protected var _container:Sprite;
      
      private var var_5239:String;
      
      protected var _inputDefaultString:String;
      
      protected var var_279:Sprite;
      
      protected var _dialogWidth:int;
      
      private var var_4097:IMessageEvent;
      
      private var var_4364:IMessageEvent;
      
      public function NameChangeDialog(param1:class_3325, param2:Sprite, param3:int)
      {
         super();
         _context = param1;
         _container = param2;
         _dialogWidth = param3;
         init();
         var_4097 = param1.communicationManager.addHabboConnectionMessageEvent(new class_1886(onChangeUserNameResult));
         var_4364 = param1.communicationManager.addHabboConnectionMessageEvent(new class_3130(onCheckUserNameResult));
         var_804 = new Timer(500,1);
         var_804.addEventListener("timer",onIdleTimer);
      }
      
      private function onChangeUserNameResult(param1:class_1886) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_1789 = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         claimNameResponse(_loc2_.resultCode,_loc2_.name,_loc2_.nameSuggestions);
      }
      
      private function onCheckUserNameResult(param1:class_3130) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_2414 = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         checkNameResponse(_loc2_.resultCode,_loc2_.name,_loc2_.nameSuggestions);
      }
      
      protected function init() : void
      {
         var_129 = LoaderUI.createFrame(_context.getLocalization("rename.title","Pick a name for your character"),"",new Rectangle(-_dialogWidth / 2,0,_dialogWidth,1),_style);
         var _loc4_:int = 23;
         var _loc3_:int = _dialogWidth - _loc4_ * 2;
         var _loc1_:int = _dialogWidth - 12;
         var_129.x = 5;
         var _loc10_:Boolean = false;
         var _loc6_:TextField = LoaderUI.createTextField(_context.getLocalization("rename.subtitle","You are a unique and beautiful snowflake."),20,0,true,false,false,_loc10_);
         _loc6_.x = _loc4_;
         LoaderUI.addEtching(_loc6_);
         var _loc8_:TextField = LoaderUI.createTextField(_context.getLocalization("rename.description","In Habbo, we all sign in using a unique name, so go ahead and enter yours. There\'s no need to use your real one - stage names are perfectly ok."),12,0,false,true,false,_loc10_);
         var_129.addChild(_loc8_);
         _loc8_.x = _loc4_;
         _loc8_.width = _loc3_;
         LoaderUI.addEtching(_loc8_);
         var _loc2_:Sprite = new Sprite();
         var_250 = NineSplitSprite.INPUT_FIELD.render(_loc3_,50);
         _loc2_.addChild(var_250);
         var_129.addChild(_loc2_);
         _loc2_.x = _loc4_;
         var _loc7_:TextField = LoaderUI.createTextField(_context.getLocalization("rename.accepted","WE ACCEPT LETTERS AND NUMBERS. NOT VISA OR MASTERCARD."),9,4342338,true,false,false,_loc10_);
         var_129.addChild(_loc7_);
         _loc7_.x = _loc4_ + 5;
         LoaderUI.addEtching(_loc7_);
         var _loc11_:TextField = LoaderUI.createTextField(_context.getLocalization("rename.warning","Once you\'ve selected a name for your character, you can\'t change it anymore, so please pay a bit of attention to your selection."),16,4342338,false,true,false,false);
         _loc11_.width = _loc3_ - 66;
         LoaderUI.addEtching(_loc11_);
         var _loc5_:Bitmap = NineSplitSprite.BORDER_SUNK.render(_loc3_,_loc11_.height + 24);
         var_279 = new Sprite();
         var_279.addChild(_loc11_);
         _loc11_.x = 50;
         _loc11_.y = 12;
         var_129.addChild(var_279);
         var_279.x = _loc4_;
         _inputDefaultString = _context.getLocalization("name","Click here to type a name");
         var_33 = LoaderUI.createTextField(_inputDefaultString,14,8947848,true,false,true,false);
         var_129.addChild(var_33);
         var_33.x = _loc2_.x + 16;
         var_33.y = _loc2_.y + int((_loc2_.height - var_33.height) / 2);
         var_33.width = _loc2_.width - 30;
         var_33.addEventListener("click",onInputClicked);
         var_33.addEventListener("change",onInputChange);
         var_259 = new WaitIndicator(_style);
         var_129.addChild(var_259);
         var_259.y = _loc2_.y + int(_loc2_.height / 2);
         var_259.x = _loc2_.x + _loc2_.width - int(var_334.width / 2) - 15;
         var_259.visible = false;
         _loc2_.addEventListener("click",onInputBackgroundClicked);
         var _loc9_:int = -50;
         LoaderUI.resizeFrame(var_129,_dialogWidth,_loc9_);
         var_129.y = -(int(_loc9_ / 2));
         var_2649 = new Dimmer();
         _container.addChild(var_129);
      }
      
      private function onIdleTimer(param1:TimerEvent) : void
      {
         checkName(var_33.text);
      }
      
      public function setNameClaimed(param1:Boolean) : void
      {
         var_4803 = param1;
      }
      
      protected function onInputChange(param1:Event) : void
      {
         if(var_804 != null)
         {
            var_804.reset();
            var_804.start();
         }
         removeIndicators();
      }
      
      protected function onInputBackgroundClicked(param1:MouseEvent) : void
      {
         _context.stage.focus = var_33;
         onInputClicked(null);
      }
      
      protected function onInputClicked(param1:Event) : void
      {
         if(_inputClickedAlready)
         {
            return;
         }
         _inputClickedAlready = true;
         var_33.text = "";
         var_33.textColor = _style == 2 ? 6710886 : 0;
         var_33.removeEventListener("click",onInputClicked);
         onInputChange(null);
      }
      
      public function submitName() : void
      {
         claimName(var_33.text);
      }
      
      private function get nameChanged() : Boolean
      {
         return var_33 != null && var_33.text != _context.getLocalization("name",_inputDefaultString);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _context.communicationManager.removeHabboConnectionMessageEvent(var_4097);
         _context.communicationManager.removeHabboConnectionMessageEvent(var_4364);
         if(var_2649)
         {
            _container.removeChild(var_2649);
         }
         if(var_129)
         {
            _container.removeChild(var_129);
         }
         if(var_259 != null)
         {
            var_259.dispose();
            var_259 = null;
         }
         var_2649 = null;
         var_33 = null;
         _submitButton = null;
         _skipButton = null;
         var_257 = null;
         var_334 = null;
         var_250 = null;
         var_129 = null;
         _context = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function claimNameResponse(param1:int, param2:Object, param3:Array) : void
      {
         nameIsCorrect = false;
         switch(param1)
         {
            case class_1886.var_1851:
               nameIsCorrect = true;
               _context.nameChangeCompleted();
               _context.editorFinished();
               break;
            case class_1886.var_2917:
               showErrorMessage(_context.getLocalization("rename.error.too_long","OOPS! YOUR NAME\'S TOO LONG TO REMEMBER"));
               break;
            case class_1886.var_2697:
               showErrorMessage(_context.getLocalization("rename.error.too_short","OOPS! YOUR NAME\'S TOO SHORT TO PRONOUNCE."));
               break;
            case class_1886.var_3157:
               showErrorMessage(_context.getLocalization("rename.error.words","OOPS! THINK HARDER - THAT\'S NOT A VERY NICE NAME."));
               break;
            case class_1886.var_3330:
            case class_1886.var_2518:
               showErrorMessage(_context.getLocalization("rename.error.taken","OOPS! SOMEONE\'S ALREADY USING THAT NAME."));
         }
      }
      
      public function claimNameFailed(param1:String) : void
      {
      }
      
      private function claimName(param1:String) : void
      {
         if(var_4803)
         {
            _context.nameChangeCompleted();
         }
         _context.communicationManager.connection.send(new class_2679(param1));
         _context.nameChangeCompleted();
      }
      
      public function checkNameResponse(param1:int, param2:String, param3:Array) : void
      {
         if(var_33 == null || var_33.text != param2)
         {
            return;
         }
         if(var_259 != null)
         {
            var_259.visible = false;
         }
         nameIsCorrect = false;
         switch(param1)
         {
            case class_1886.var_1851:
               nameIsCorrect = true;
               break;
            case class_1886.var_2917:
               showErrorMessage(_context.getLocalization("rename.error.too_long","OOPS! YOUR NAME\'S TOO LONG TO REMEMBER"));
               break;
            case class_1886.var_2697:
               showErrorMessage(_context.getLocalization("rename.error.too_short","OOPS! YOUR NAME\'S TOO SHORT TO PRONOUNCE."));
               break;
            case class_1886.var_3157:
               showErrorMessage(_context.getLocalization("rename.error.words","OOPS! THINK HARDER - THAT\'S NOT A VERY NICE NAME."));
               break;
            case class_1886.var_3330:
            case class_1886.var_2518:
               showErrorMessage(_context.getLocalization("rename.error.taken","OOPS! SOMEONE\'S ALREADY USING THAT NAME."));
         }
         if(var_279 != null)
         {
            var_279.visible = !nameIsCorrect;
            _context.showHideButtons(nameIsCorrect);
         }
      }
      
      public function checkNameFailed(param1:String) : void
      {
      }
      
      private function checkName(param1:String) : void
      {
         if(!param1 || param1.length == 0)
         {
            return;
         }
         _context.communicationManager.connection.send(new class_2461(param1));
         if(var_259 != null)
         {
            var_259.visible = true;
         }
      }
      
      protected function get nameIsCorrect() : Boolean
      {
         return var_334 != null && var_334.visible;
      }
      
      protected function set nameIsCorrect(param1:Boolean) : void
      {
         param1 = true;
         if(var_334 != null)
         {
            var_334.visible = param1;
         }
         if(var_972 != null)
         {
            var_972.visible = !param1;
         }
         if(_submitButton != null)
         {
            _submitButton.active = true;
            if(_style == 2)
            {
               _submitButton.visible = true;
               _submitButton.active = nameChanged ? param1 : true;
            }
            else
            {
               _submitButton.visible = param1 && nameChanged;
            }
         }
         if(_skipButton != null)
         {
            if(_style == 2)
            {
               _skipButton.visible = nameChanged;
            }
         }
      }
      
      private function showErrorMessage(param1:String) : void
      {
         var _loc5_:TextField = null;
         var _loc4_:Bitmap = null;
         var _loc2_:Shape = null;
         var _loc3_:int = var_250.width;
         var _loc6_:int = var_250.height;
         var_250.bitmapData = _style == 2 ? NineSplitSprite.INPUT_ERROR_HITCH.render(_loc3_,_loc6_).bitmapData : NineSplitSprite.INPUT_ERROR.render(_loc3_,_loc6_).bitmapData;
         removeIndicators();
         if(var_972 != null)
         {
            var_972.visible = true;
         }
         if(_style == 1)
         {
            _loc5_ = LoaderUI.createTextField(param1,9,16777215,true);
            _loc4_ = LoaderUI.createBalloon(_loc5_.width + 30,_loc5_.height + 17,-1,true,11411485);
            var_257 = new Sprite();
            var_257.addChild(_loc4_);
            var_257.addChild(_loc5_);
            _loc5_.x = 15;
            _loc5_.y = 14;
         }
         else
         {
            _loc5_ = LoaderUI.createTextField(param1,10,16777215);
            _loc2_ = LoaderUI.createScale9GridShapeFromImage(Bitmap(new input_error_alert_hitch_png()).bitmapData,new Rectangle(3,3,5,5));
            _loc3_ = var_250.width;
            if(_loc5_.width > _loc3_)
            {
               _loc3_ = _loc5_.width + 20;
            }
            _loc2_.width = _loc3_;
            _loc2_.height = var_250.height - 11;
            var_257 = new Sprite();
            var_257.addChild(_loc2_);
            var_257.addChild(_loc5_);
            _loc5_.x = 16;
            _loc5_.y = int((_loc2_.height - _loc5_.height) / 2);
         }
         var_129.addChild(var_257);
         if(_style == 1)
         {
            var_257.x = int((var_129.width - var_257.width) / 2);
            var_257.y = var_250.parent.y + var_250.height;
            var_257.filters = [new GlowFilter(0,0.24,6,6)];
         }
         else
         {
            var_257.x = var_250.parent.x;
            var_257.y = var_250.parent.y + var_250.height + 4;
         }
      }
      
      private function removeIndicators() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(var_257 != null && var_129.contains(var_257))
         {
            _loc1_ = var_250.width;
            _loc2_ = var_250.height;
            var_250.bitmapData = _style == 2 ? NineSplitSprite.INPUT_CORRECTED_HITCH.render(_loc1_,_loc2_).bitmapData : NineSplitSprite.INPUT_CORRECTED.render(_loc1_,_loc2_).bitmapData;
            var_129.removeChild(var_257);
         }
         var_334.visible = false;
         if(var_972 != null)
         {
            var_972.visible = false;
         }
      }
      
      public function set preSelectedGender(param1:String) : void
      {
         var_5239 = param1;
      }
   }
}

