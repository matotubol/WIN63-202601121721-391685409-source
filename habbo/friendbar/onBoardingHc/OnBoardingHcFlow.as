package com.sulake.habbo.friendbar.onBoardingHc
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.friendbar.onBoardingHcSteps.AvatarEditor;
   import com.sulake.habbo.friendbar.onBoardingHcSteps.Background;
   import com.sulake.habbo.friendbar.onBoardingHcSteps.RoomPicker;
   import com.sulake.habbo.localization.class_27;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import onBoardingHcUi.LoaderUI;
   
   public class OnBoardingHcFlow extends Sprite implements class_3325, class_13
   {
      
      public static const const_360:String = "NewUserFlowFinished";
      
      private static const LOGO_AREA_HEIGHT:int = 95;
      
      private static const MAIN_AREA_MARGIN:int = 0;
      
      public static const AVATAR_NAME_CHANGE:int = 0;
      
      public static const const_603:int = 1;
      
      public static var ubuntu_regular:Class = class_3915;
      
      public static var ubuntu_bold:Class = class_3913;
      
      public static var ubuntu_italic:Class = class_3914;
      
      public static var ubuntu_bold_italic:Class = class_3912;
      
      private static const habbo_logo_png:Class = class_4070;
      
      private var _background:Background;
      
      private var _avatarEditor:AvatarEditor;
      
      private var var_454:Sprite;
      
      private var var_129:NameChangeDialog;
      
      private var var_504:Sprite;
      
      private var var_2979:RoomPicker;
      
      private var var_1134:Boolean;
      
      private var _avatarRenderManager:class_48;
      
      private var _localizationManager:class_27;
      
      private var _communicationManager:class_57;
      
      private var var_257:Sprite;
      
      private var var_5192:Boolean;
      
      private var var_4803:Boolean;
      
      private var _mainSprite:Sprite;
      
      private var var_3158:Sprite;
      
      private var _selectedName:String;
      
      private var _isFemale:Boolean;
      
      private var var_481:TextField;
      
      private var var_5291:TextField;
      
      private var _showHcItems:Boolean;
      
      private var var_2251:int = 535;
      
      private var _nameAreaWidth:int = 400;
      
      private var var_1452:Array = [];
      
      public function OnBoardingHcFlow(param1:class_48, param2:class_27, param3:class_57)
      {
         super();
         _avatarRenderManager = param1;
         _localizationManager = param2;
         _communicationManager = param3;
      }
      
      public function dispose() : void
      {
         if(var_1134)
         {
            return;
         }
         if(_background)
         {
            removeChild(_background);
            _background.dispose();
            _background = null;
         }
         if(_avatarEditor)
         {
            _avatarEditor.dispose();
            _avatarEditor = null;
         }
         if(var_129)
         {
            var_129.dispose();
            var_129 = null;
         }
         if(var_454)
         {
            var_454 = null;
         }
         if(var_504 != null)
         {
            var_504 = null;
         }
         if(_mainSprite != null)
         {
            removeChild(_mainSprite);
            _mainSprite = null;
         }
         _avatarRenderManager = null;
         _localizationManager = null;
         _communicationManager = null;
         stage.removeChild(this);
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function init(param1:Array) : void
      {
         var_1452 = param1;
         stage.addEventListener("resize",onStageResize);
         _background = new Background();
         addChild(_background);
         var_3158 = new Sprite();
         addChild(var_3158);
         var _loc2_:Bitmap = new habbo_logo_png();
         _loc2_.x = 40;
         _loc2_.y = 40;
         var_3158.addChild(_loc2_);
         _mainSprite = new Sprite();
         addChild(_mainSprite);
         _mainSprite.y = 95;
         _mainSprite.x = 0;
         _avatarEditor = new AvatarEditor(this);
         _avatarEditor.showHcItems(_showHcItems);
         _mainSprite.addChild(_avatarEditor);
         var_454 = new Sprite();
         var_454.x = var_2251;
         var_454.y = 95;
         var_454.visible = true;
         _mainSprite.addChild(var_454);
         var_504 = new Sprite();
         var_504.x = 0;
         var_504.y = 95;
         var_504.visible = false;
         _mainSprite.addChild(var_504);
         if(isRoomPickingNeeded)
         {
            var_2979 = new RoomPicker(this,var_504);
            var_2979.fetchThumbnails();
         }
         if(!var_1452)
         {
            dispatchEvent(new Event("NewUserFlowFinished"));
            return;
         }
         if(var_1452.indexOf(0) >= 0)
         {
         }
         if(var_1452.indexOf(1) >= 0)
         {
         }
         if(var_1452.indexOf(0) >= 0)
         {
            startNameChange();
         }
         else
         {
            startRoomPicking();
         }
      }
      
      public function setHcVisibility(param1:Boolean) : void
      {
         _showHcItems = param1;
      }
      
      private function onStageResize(param1:Event) : void
      {
         if(disposed)
         {
            return;
         }
         layoutMainElements();
      }
      
      private function layoutMainElements() : void
      {
         var _loc2_:int = 0;
         if(_background != null)
         {
            _background.resize();
         }
         if(var_504)
         {
            var_504.x = 0;
         }
         if(!var_481)
         {
            var_481 = LoaderUI.createTextField("intro",40,16777215,false,true,false,false,"left");
            var_481.x = 185;
            var_481.y = 45;
            var_481.width = 500;
            var_481.multiline = false;
            var_481.thickness = 50;
            var_3158.addChild(var_481);
         }
         var _loc1_:int = _mainSprite.width + 20;
         if(stage.stageWidth > _loc1_)
         {
            _loc2_ = (stage.stageWidth - _loc1_) / 2;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _mainSprite.x = _loc2_;
         }
         else
         {
            _mainSprite.x = 0;
         }
         if(_avatarEditor)
         {
            _avatarEditor.x = 0;
            var_2251 = _avatarEditor.x + _avatarEditor.width - 125;
         }
         if(var_454)
         {
            var_454.x = var_2251;
         }
         _mainSprite.y = 95;
      }
      
      public function getLocalization(param1:String, param2:String = null) : String
      {
         if(!_localizationManager)
         {
            return param2;
         }
         return _localizationManager.getLocalization(param1,param2);
      }
      
      public function getProperty(param1:String, param2:String = null) : String
      {
         if(!_localizationManager)
         {
            return param2;
         }
         var _loc3_:String = _localizationManager.getProperty(param1);
         return _loc3_ ? _loc3_ : param2;
      }
      
      public function showErrorMessage(param1:String) : void
      {
         var _loc3_:TextField = LoaderUI.createTextField(param1,9,16777215,true);
         LoaderUI.addEtching(_loc3_,true);
         var _loc2_:Bitmap = LoaderUI.createBalloon(_loc3_.width + 30,_loc3_.height + 17,-1,true,11411485);
         if(var_257)
         {
            removeChild(var_257);
         }
         var_257 = new Sprite();
         var_257.addChild(_loc2_);
         var_257.addChild(_loc3_);
         _loc3_.x = 15;
         _loc3_.y = 14;
         _mainSprite.addChild(var_257);
         var_257.x = 766;
         var_257.y = 577;
         var_257.filters = [new GlowFilter(0,0.24,6,6)];
      }
      
      public function get avatarRenderManager() : class_48
      {
         return _avatarRenderManager;
      }
      
      public function get selectedName() : String
      {
         return _selectedName;
      }
      
      public function get isFemale() : Boolean
      {
         return _isFemale;
      }
      
      public function get communicationManager() : class_57
      {
         return _communicationManager;
      }
      
      public function editorFinished() : void
      {
         if(isRoomPickingNeeded)
         {
            startRoomPicking();
         }
         else
         {
            dispatchEvent(new Event("NewUserFlowFinished"));
         }
      }
      
      public function setHcMembership(param1:Boolean) : void
      {
         var_5192 = param1;
      }
      
      public function submitName() : void
      {
         if(var_129 != null && var_454.visible)
         {
            var_129.submitName();
         }
         else
         {
            nameChangeCompleted();
            editorFinished();
         }
      }
      
      private function startNameChange() : void
      {
         if(!var_129)
         {
            var_129 = new HitchNameChangeDialog(this,var_454,getNameAreaWidth());
         }
         if(var_504)
         {
            var_504.visible = false;
         }
         var_454.visible = true;
         var_454.x = var_2251;
         var_129.preSelectedGender = _avatarEditor.gender;
         layoutMainElements();
         showChooseStyleHeader();
      }
      
      public function setNameGender(param1:String, param2:Boolean) : void
      {
         _selectedName = param1;
         _isFemale = param2;
      }
      
      public function setIsFemale(param1:Boolean) : void
      {
         _isFemale = param1;
      }
      
      public function nameChangeCompleted(param1:Boolean = true) : void
      {
         var_4803 = param1;
         _avatarEditor.nameChangeCompleted(param1);
      }
      
      public function showHideButtons(param1:Boolean) : void
      {
         _avatarEditor.showHideButtons(param1);
      }
      
      private function get isRoomPickingNeeded() : Boolean
      {
         return var_1452.indexOf(1) >= 0;
      }
      
      private function startRoomPicking() : void
      {
         if(var_2979 == null)
         {
            return;
         }
         _avatarEditor.visible = false;
         _avatarEditor.showHideGrid(false);
         var_454.visible = false;
         var_504.visible = true;
         var_2979.init();
         layoutMainElements();
         showPickRoomHeader();
      }
      
      public function showPickRoomHeader() : void
      {
         if(var_481)
         {
            var_481.width = 650;
            var_481.htmlText = getLocalization("onboarding.choose.your.room","Choose your room");
         }
      }
      
      public function showChooseStyleHeader() : void
      {
         if(var_481)
         {
            var_481.width = 650;
            var_481.htmlText = getLocalization("onboarding.choose.your.style","My looks");
         }
      }
      
      public function roomPickingCompleted() : void
      {
         dispatchEvent(new Event("NewUserFlowFinished"));
      }
      
      public function get debugText() : TextField
      {
         return null;
      }
      
      public function getNameAreaX() : int
      {
         return var_2251;
      }
      
      public function getNameAreaWidth() : int
      {
         return _nameAreaWidth;
      }
   }
}

