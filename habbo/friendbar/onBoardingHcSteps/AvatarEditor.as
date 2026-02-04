package com.sulake.habbo.friendbar.onBoardingHcSteps
{
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.avatar.enum.AvatarFigurePartType;
   import com.sulake.habbo.avatar.structure.class_1780;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.avatar.structure.figure.class_1932;
   import com.sulake.habbo.avatar.structure.figure.class_2017;
   import com.sulake.habbo.avatar.structure.figure.class_3134;
   import com.sulake.habbo.friendbar.onBoardingHc.OnBoardingHcFlow;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import onBoardingHcUi.Button;
   import onBoardingHcUi.ColorButton;
   import onBoardingHcUi.ColouredButton;
   import onBoardingHcUi.LoaderUI;
   import onBoardingHcUi.RadioButton;
   import onBoardingHcUi.RadioButtonGroup;
   import onBoardingHcUi.RoundButton;
   import onBoardingHcUi.randomizeButton;
   import package_177.class_3061;
   
   public class AvatarEditor extends Sprite implements class_259
   {
      
      private static const SAVE_OUTFIT_FUNCTION:String = "NewUserReception.saveOutfit";
      
      private static const SAVE_OUTFIT_RESPONSE_CALLBACK:String = "newUserReceptionSaveOutfitResponse";
      
      private static const SAVE_OUTFIT_FAILED_CALLBACK:String = "newUserReceptionSaveOutfitFailed";
      
      private static const RETURN_FROM_PAYMENT:String = "newUserReturnFromPayment";
      
      private static const CHECK_FOR_HC_MEMBERSHIP_FUNCTION:String = "NewUserReception.newUserCheckHcMembership";
      
      private static const CHECK_FOR_HC_MEMBERSHIP_CALLBACK:String = "checkForHcMembership";
      
      public static const GENDER_MALE:String = "M";
      
      public static const GENDER_FEMALE:String = "F";
      
      public static const GENDER_UNISEX:String = "U";
      
      private static const NORMAL_ITEMS_TO_SHOW:int = 5;
      
      private static const THUMBS_PER_ROW:int = 5;
      
      private static const COLORS_PER_ROW:int = 4;
      
      private static const COLOR_ROWS:int = 4;
      
      private static const CLUB_COLOR_ROWS:int = 3;
      
      private static const RANDOM_MALE_FIGURES:Array = ["hr-891-34.hd-209-10.ch-255-71.lg-280-81","hr-893-42.hd-209-19.ch-230-80.lg-3290-82.sh-906-64","hr-889-34.hd-200-1.ch-3030-73.lg-3023-88.sh-300-64","hr-145-42.hd-185-1.ch-230-66.lg-270-82.sh-290-81","hr-110-38.hd-190-1.ch-3030-85.lg-275-84.sh-290-74","hr-891-42.hd-190-14.ch-230-64.lg-3290-64.sh-906-64","hr-110-35.hd-185-1.ch-3110-80-25.lg-270-84.sh-905-80","hr-145-43.hd-209-1.ch-809-80.lg-275-82.sh-906-64","hr-889-42.hd-207-1370.ch-230-80.lg-280-80.sh-906-64","hr-891-48.hd-200-1370.ch-809-84.lg-3290-84.sh-300-84","hd-190-30.ch-230-82.lg-275-72.sh-905-88","hd-185-10.ch-3110-85-25.lg-275-82.sh-300-84","hr-893-40.hd-200-14.ch-255-75.lg-280-75.sh-906-75","hr-889-45.hd-190-1370.ch-255-68.lg-3023-88.sh-906-68","hr-110-45.hd-200-1371.ch-255-85.lg-280-84.sh-3068-85-25","hr-893-35.hd-185-10.ch-230-1408.lg-275-72","hr-145-42.hd-200-10.ch-255-64.lg-3290-64.sh-906-64","hr-889-42.hd-209-10.ch-809-81.lg-3290-64.sh-300-64","hr-110-39.hd-190-1371.ch-3110-80-25.lg-275-81.sh-3068-83-25"
      ,"hr-891-48.hd-185-20.ch-3030-71.lg-3023-80.sh-300-81","hr-145-37.hd-200-1.ch-3030-75.lg-270-80.sh-3068-83-25","hr-891-44.hd-207-1.ch-809-76.lg-270-76.sh-3068-76-25","hr-145-48.hd-185-20.ch-3110-76-25.lg-270-74.sh-290-75","hr-110-44.hd-200-30.ch-809-83.lg-270-84.sh-300-64","hr-891-34.hd-207-14.ch-230-81.lg-270-76.sh-290-80"];
      
      private static const RANDOM_FEMALE_FIGURES:Array = ["hr-891-40.hd-627-1371.ch-665-66.lg-700-82.sh-3068-68-25","hr-515-48.hd-628-1.ch-635-73.lg-695-81.sh-735-83","hr-891-35.hd-625-8.ch-685-73.lg-715-73.sh-907-73","hr-837-45.hd-627-14.ch-670-76.lg-695-71.sh-907-73","hr-892-48.hd-605-14.ch-685-64.lg-700-72.sh-906-64","hr-893-32.hd-628-20.ch-823-76.lg-710-82.sh-735-76","hr-892-32.hd-628-1.ch-665-81.lg-700-80.sh-3068-81-25","hr-893-40.hd-610-12.ch-670-81.lg-716-81-25.sh-725-83","hr-891-42.hd-625-10.ch-635-64.lg-695-64.sh-906-64","hd-625-1370.ch-823-72.lg-710-74.sh-725-74","hr-515-45.hd-628-1.ch-823-75.lg-710-73.sh-3068-84-25","hr-893-34.hd-605-19.ch-685-84.lg-695-85.sh-906-85","hr-837-39.hd-610-1.ch-685-91.lg-695-90.sh-906-80","hr-891-34.hd-610-1369.ch-635-74.lg-695-82.sh-906-71","hr-892-39.hd-628-1370.ch-670-64.lg-716-64-25.sh-907-64","hr-837-46.hd-627-20.ch-665-76.lg-716-68-25","hr-892-37.hd-605-10.ch-665-88.lg-700-88","hr-892-48.hd-628-1371.ch-823-82.lg-700-71.sh-725-81","hr-891-36.hd-625-8.ch-670-80.lg-715-80.sh-907-80"
      ,"hr-891-48.hd-628-12.ch-823-64.lg-715-64.sh-907-76","hr-837-48.hd-627-14.ch-685-73.lg-695-76.sh-907-82","hr-893-48.hd-605-1371.ch-665-74.lg-700-72.sh-725-74","hr-515-35.hd-625-10.ch-665-72.lg-695-72.sh-906-64","hr-837-35.hd-628-1.ch-635-81.lg-710-75.sh-735-81","hr-893-44.hd-628-30.ch-670-76.lg-715-76.sh-907-76"];
      
      private static const button_boy_png:Class = button_boy_png$6113df9b523c0e75bb97ba6d732568c6258011444;
      
      private static const button_girl_png:Class = class_4097;
      
      private static const button_boy_active_png:Class = class_4095;
      
      private static const button_girl_active_png:Class = class_4096;
      
      private static const avatar_halo_png:Class = class_4092;
      
      private static const avatar_glow_png:Class = class_4091;
      
      private static const hc_header_png:Class = class_4107;
      
      private static const hc_teaser_png:Class = onb_habbos_png$da21f97cd7bbff0bf1bb0f8e03c11ab81000471934;
      
      private static const block_alert_png:Class = block_alert_png$9f7e87b291fa5d4cceaab41f94e2f1ce2039170795;
      
      private static const icon_alert_png:Class = icon_alert_white_png$7106b8481bad5a5be42a1d839c63d8fb2101663925;
      
      private static const rnd_button_png:Class = rnd_button_png$1b8c8487abd689e5e141614f8d34af211170555822;
      
      private static const CATEGORIES:Array = ["hr","hd","ch","lg","sh"];
      
      private static const EXTRA_CATEGORIES:Array = [];
      
      private var var_1312:Sprite;
      
      private var var_354:Button;
      
      private var var_111:String = "M";
      
      private var _thumbs:Dictionary;
      
      private var _colors:Dictionary;
      
      private var var_403:Dictionary;
      
      private var var_1426:Dictionary;
      
      private var var_1844:String = "hr";
      
      private var var_608:Sprite;
      
      private var var_1779:Sprite;
      
      private var _figureContainer:Bitmap;
      
      private var var_3588:randomizeButton;
      
      private var _context:OnBoardingHcFlow;
      
      private var var_1134:Boolean;
      
      private var var_541:ColouredButton;
      
      private var var_2070:RadioButton;
      
      private var var_2247:RadioButton;
      
      private var _genderButtonGroup:RadioButtonGroup;
      
      private var var_3919:Array = [];
      
      private var var_5192:Boolean;
      
      private var var_888:Sprite;
      
      private var var_5197:Sprite;
      
      private var _showHcItems:Boolean;
      
      private var var_2987:Array = [];
      
      private var var_2344:Array = [];
      
      private var _selectedColors:Dictionary = new Dictionary();
      
      private var var_1537:RandomAvatarCloudsAnimation;
      
      private var var_3368:Dictionary = new Dictionary();
      
      public function AvatarEditor(param1:OnBoardingHcFlow)
      {
         super();
         _context = param1;
         var_111 = "M";
         var_403 = new Dictionary();
         var_1426 = new Dictionary();
         addEventListener("addedToStage",onAddedToStage);
         addEventListener("removedFromStage",onRemovedFromStage);
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
      }
      
      public function showHcItems(param1:Boolean) : void
      {
         _showHcItems = param1;
      }
      
      private function addFigureImage() : void
      {
         var _loc1_:int = _context.getNameAreaX();
         var _loc4_:int = _context.getNameAreaWidth();
         _figureContainer = new Bitmap();
         _figureContainer.x = _loc1_ + _loc4_ / 2 + 15;
         _figureContainer.y = 90;
         _figureContainer.scaleX = 2;
         _figureContainer.scaleY = 2;
         var _loc3_:Bitmap = new avatar_halo_png();
         _loc3_.x = _figureContainer.x + 35;
         _loc3_.y = 290;
         _loc3_.blendMode = "overlay";
         var _loc2_:Bitmap = new avatar_glow_png();
         _loc2_.x = _figureContainer.x - 55;
         _loc2_.y = 90;
         _loc2_.blendMode = "add";
         addChild(_loc3_);
         addChild(_loc2_);
         addChild(_figureContainer);
         var_1537 = new RandomAvatarCloudsAnimation();
         var_1537.x = _figureContainer.x;
         var_1537.y = _figureContainer.y;
         addChild(var_1537);
         var_1537.visible = false;
      }
      
      private function addHeaders() : void
      {
         var _loc3_:TextField = LoaderUI.createTextField("headerText",24,8309486,false,true,false,false);
         _loc3_.width = 300;
         _loc3_.thickness = 50;
         addChild(_loc3_);
         _loc3_.htmlText = _context.getLocalization("onboarding.your.looks","Choose looks");
         _loc3_.x = 35;
         _loc3_.y = 5;
         var _loc1_:TextField = LoaderUI.createTextField("headerText",24,8309486,false,true,false,false);
         _loc1_.width = 300;
         _loc1_.thickness = 50;
         addChild(_loc1_);
         _loc1_.htmlText = _context.getLocalization("onboarding.your.colour","Choose colour");
         _loc1_.x = 370;
         _loc1_.y = 5;
         var _loc2_:TextField = LoaderUI.createTextField("headerText",24,8309486,false,true,false,false);
         _loc2_.width = 300;
         _loc2_.thickness = 50;
         addChild(_loc2_);
         _loc2_.htmlText = _context.getLocalization("onboarding.this.is.your.habbo","This is your Habbo");
         _loc2_.x = 650;
         _loc2_.y = 5;
      }
      
      public function addGenderButtons() : void
      {
         var _loc2_:int = _context.getNameAreaX();
         var _loc6_:int = _context.getNameAreaWidth();
         _genderButtonGroup = new RadioButtonGroup(onChooseGender);
         var _loc1_:BitmapData = Bitmap(new button_boy_active_png()).bitmapData;
         var _loc8_:BitmapData = Bitmap(new button_boy_png()).bitmapData;
         var _loc7_:BitmapData = Bitmap(new button_girl_active_png()).bitmapData;
         var _loc4_:BitmapData = Bitmap(new button_girl_png()).bitmapData;
         var _loc3_:Sprite = new Sprite();
         _loc3_.y = 105;
         var_2070 = new RadioButton(_context.getLocalization("gender.male","Male"),_genderButtonGroup,2,_loc1_,_loc8_,8231575);
         var_2070.name = "M";
         var_2247 = new RadioButton(_context.getLocalization("gender.female","Female"),_genderButtonGroup,2,_loc7_,_loc4_,8231575);
         var_2247.name = "F";
         _loc3_.addChild(var_2070);
         _loc3_.addChild(var_2247);
         _loc3_.x = _loc2_ + 120;
         addChild(_loc3_);
         var_541 = new ColouredButton("gfreen",_context.getLocalization("onboarding.button.ready","I\'m ready"),new Rectangle(685,435,0,40),true,saveOutfit,14211288);
         var_541.x = _loc2_ + (_loc6_ - var_541.width) / 2 + 20;
         addChild(var_541);
         var_3588 = new randomizeButton(0,-10,onRandomize,14211288);
         _loc3_.addChild(var_3588);
         LoaderUI.lineUpHorizontally(var_2070,60,var_2247,30,var_3588);
         var _loc5_:TextField = LoaderUI.createTextField("bottomText",12,16777215,true,true,false,false);
         _loc5_.htmlText = _context.getLocalization("onboarding.cant.decide","Can\'t decide? Don\'t worry, you can change your clothes later!");
         _loc5_.width = 300;
         _loc5_.x = 715;
         _loc5_.y = 380;
         addChild(_loc5_);
      }
      
      private function addHcTeaserBox() : void
      {
         var _loc5_:Bitmap = Bitmap(new hc_teaser_png());
         var_888 = new Sprite();
         addChild(var_888);
         var _loc6_:Bitmap = LoaderUI.createBalloon(650,160,0,false,861246,"none");
         var_888.addChild(_loc6_);
         var_888.addChild(_loc5_);
         _loc5_.x = 20;
         _loc5_.y = 24;
         var_888.x = 41;
         var_888.y = 385;
         var_888.visible = true;
         var _loc4_:TextField = LoaderUI.createTextField(_context.getLocalization("onboard.what.is.hc.header","Much more inside... "),24,8309486,true,true,false,false);
         var _loc2_:String = _context.getLocalization("onboard.what.is.hc.description","onboard.what.is.hc.description");
         var _loc3_:TextField = LoaderUI.createTextField(_loc2_,12,16777215,true,true,false,false);
         _loc3_.multiline = true;
         _loc3_.width = 300;
         _loc4_.width = 300;
         _loc4_.x = 320;
         _loc4_.y = 15;
         _loc3_.x = 320;
         _loc3_.y = 45;
         var_888.addChild(_loc4_);
         var_888.addChild(_loc3_);
         var _loc1_:Bitmap = new hc_header_png();
         _loc1_.x = 320;
         _loc1_.y = -45;
         var_888.addChild(_loc1_);
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         addFigureImage();
         addHeaders();
         addGenderButtons();
         var_608 = new Sprite();
         var_608.x = 40;
         var_608.y = 50;
         addChild(var_608);
         var_1779 = new Sprite();
         var_1779.x = 40;
         var_1779.y = 365;
         addChild(var_1779);
         var_1312 = new Sprite();
         var_1312.x = 375;
         var_1312.y = 50;
         addChild(var_1312);
         populateColors();
         renderColors();
         var_2070.selected = true;
         var_403[var_111] = new Dictionary();
         var_1426[var_111] = new Dictionary();
         setRandomFigure();
      }
      
      private function onChooseGender() : void
      {
         var _loc1_:RadioButton = _genderButtonGroup.selected;
         if(_loc1_ == null)
         {
            return;
         }
         var_111 = _loc1_.name;
         _context.setIsFemale(var_111 == "F");
         if(var_403[var_111] == null)
         {
            var_403[var_111] = new Dictionary();
            var_1426[var_111] = new Dictionary();
         }
         setRandomFigure();
      }
      
      private function clearGrids() : void
      {
         while(var_608.numChildren > 0)
         {
            var_608.removeChildAt(0);
         }
         while(var_1779.numChildren > 0)
         {
            var_1779.removeChildAt(0);
         }
         _thumbs = new Dictionary();
      }
      
      private function updateGrids(param1:Boolean) : void
      {
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc17_:Array = null;
         var _loc4_:String = null;
         var _loc8_:Array = null;
         var _loc14_:String = null;
         var _loc11_:String = null;
         var _loc5_:RoundButton = null;
         var _loc6_:class_1827 = null;
         var _loc3_:BitmapData = null;
         var _loc7_:Array = null;
         var _loc2_:int = 0;
         var _loc16_:int = 0;
         var _loc15_:String = null;
         clearGrids();
         populateThumbs();
         _loc13_ = 0;
         while(_loc13_ < CATEGORIES.length)
         {
            _loc14_ = CATEGORIES[_loc13_];
            _loc17_ = _thumbs[_loc14_];
            _loc7_ = var_1426[var_111][_loc14_];
            if(_loc14_ == "hr")
            {
               var_2344 = [];
            }
            _loc2_ = 5;
            _loc16_ = Math.min(_loc17_.length,_loc2_);
            _loc12_ = 0;
            while(_loc12_ < _loc16_)
            {
               _loc4_ = _loc17_[_loc12_];
               _loc8_ = _loc4_.split("-");
               _loc14_ = _loc8_[0];
               _loc11_ = _loc8_[1];
               if(_loc7_ && _loc7_.length > 1)
               {
                  var_3368[_loc11_] = _loc7_;
               }
               _loc9_ = _loc12_ * 50 + _loc12_ * 10;
               _loc10_ = _loc13_ * 53 + _loc13_ * 10;
               _loc5_ = new RoundButton(_loc9_,_loc10_,gridClick);
               var_608.addChild(_loc5_);
               var_2987.push(_loc5_);
               if(_loc14_ == "hr")
               {
                  var_2344.push(_loc5_);
               }
               if(param1)
               {
                  _loc6_ = _context.avatarRenderManager.createAvatarImage(_loc8_.concat(_loc7_).join("-"),"h",null,this);
               }
               else
               {
                  _loc6_ = _context.avatarRenderManager.createAvatarImage(_loc8_.concat(_loc7_).join("-"),"h");
               }
               _loc3_ = _loc6_.getCroppedImage(_loc14_ == "hd" ? "head" : "full");
               _loc5_.addIcon(_loc3_);
               _loc5_.name = _loc14_ + "_" + _loc11_;
               if(var_354 != null && _loc5_.name == var_354.name)
               {
                  _loc5_.select();
                  var_354 = _loc5_;
                  var_354.currentlyEditing();
               }
               _loc12_++;
            }
            _loc13_++;
         }
         _loc9_ = 0;
         _loc13_ = 0;
         while(_loc13_ < EXTRA_CATEGORIES.length)
         {
            _loc14_ = EXTRA_CATEGORIES[_loc13_];
            _loc17_ = _thumbs[_loc14_];
            _loc7_ = var_1426[var_111][_loc14_];
            _loc12_ = 0;
            while(_loc12_ < _loc17_.length)
            {
               _loc4_ = _loc17_[_loc12_];
               _loc8_ = _loc4_.split("-");
               _loc14_ = _loc8_[0];
               _loc11_ = _loc8_[1];
               _loc9_ += 60;
               _loc10_ = 0;
               _loc5_ = new RoundButton(_loc9_,_loc10_,gridClick);
               var_1779.addChild(_loc5_);
               var_2987.push(_loc5_);
               _loc15_ = _loc7_ != null ? _loc8_.concat(_loc7_).join("-") : _loc4_;
               if(param1)
               {
                  _loc6_ = _context.avatarRenderManager.createAvatarImage(_loc15_,"h",null,this);
               }
               else
               {
                  _loc6_ = _context.avatarRenderManager.createAvatarImage(_loc15_,"h");
               }
               _loc5_.addIcon(_loc6_.getCroppedImage(_loc14_ == "hd" ? "head" : "full"));
               _loc5_.name = _loc14_ + "_" + _loc11_;
               if(var_354 != null && _loc5_.name == var_354.name)
               {
                  _loc5_.select();
                  var_354 = _loc5_;
               }
               _loc12_++;
            }
            _loc13_++;
         }
         updateSelections();
      }
      
      private function updateFigure() : void
      {
         var _loc2_:BitmapData = null;
         var _loc1_:class_1827 = _context.avatarRenderManager.createAvatarImage(getFigure(),"h",var_111,this);
         if(_loc1_)
         {
            _loc1_.setDirection("full",4);
            _loc2_ = _loc1_.getImage("full",false);
            if(_loc2_)
            {
               _figureContainer.bitmapData = _loc2_;
            }
         }
         updateSelections();
      }
      
      public function getFigure() : String
      {
         var _loc2_:int = 0;
         var _loc6_:Array = null;
         var _loc5_:ColorButton = null;
         var _loc4_:* = false;
         var _loc1_:Array = [];
         if(var_403 && var_403[var_111])
         {
            for(var _loc3_ in var_403[var_111])
            {
               _loc2_ = int(var_403[var_111][_loc3_]);
               _loc6_ = var_1426[var_111][_loc3_];
               if(_loc6_ && _loc6_.length > 1)
               {
                  _loc6_[1] = "25";
               }
               _loc1_.push([_loc3_,_loc2_].concat(_loc6_).join("-"));
               if(!_loc4_)
               {
                  _loc4_ = var_3919.indexOf(_loc2_) > -1;
                  _loc5_ = _selectedColors[_loc3_];
                  if(_loc5_ != null && _loc5_.club)
                  {
                     _loc4_ = true;
                  }
               }
            }
         }
         return _loc1_.join(".");
      }
      
      public function setRandomFigure() : void
      {
         var _loc2_:Array = null;
         var _loc14_:ColorButton = null;
         var _loc12_:ColorButton = null;
         var _loc10_:String = null;
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         var _loc7_:Array = null;
         var _loc13_:String = null;
         var _loc4_:int = 0;
         var _loc8_:String = getRandomFigureData();
         var _loc9_:Array = _loc8_.split(".");
         var _loc6_:Dictionary = var_403[var_111];
         var _loc11_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc9_.length)
         {
            _loc3_ = String(_loc9_[_loc5_]).split("-");
            _loc7_ = [];
            if(_loc3_.length >= 3)
            {
               _loc13_ = _loc3_[0];
               if(_loc6_[_loc13_] == _loc3_[1])
               {
                  _loc11_++;
               }
               var_403[var_111][_loc13_] = _loc3_[1];
               _loc7_.push(_loc3_[2]);
               _loc2_ = _colors[_loc13_];
               _loc4_ = 0;
               while(_loc4_ < _loc2_.length)
               {
                  _loc14_ = _loc2_[_loc4_];
                  if(_loc14_.name == _loc13_ + "_" + _loc3_[2])
                  {
                     colorSelected(_loc14_);
                  }
                  _loc4_++;
               }
               if(_loc3_.length > 3)
               {
                  _loc7_.push(_loc3_[3]);
               }
               var_1426[var_111][_loc13_] = _loc7_;
            }
            if(_loc13_ == "hr")
            {
               _loc10_ = _loc13_ + "_" + _loc3_[1];
               _loc12_ = _loc14_;
            }
            _loc5_++;
         }
         var_1844 = "hr";
         for each(var _loc1_ in var_2344)
         {
            if(_loc1_.name == _loc10_)
            {
               gridClick(_loc1_);
               gridClick(_loc1_);
            }
         }
         var_1537.visible = true;
         var_1537.startAnimation();
         if(_loc11_ >= _loc9_.length - 1)
         {
            setRandomFigure();
         }
      }
      
      private function getRandomFigureData() : String
      {
         var _loc2_:Array = null;
         if(var_111 == "M")
         {
            _loc2_ = RANDOM_MALE_FIGURES;
         }
         else
         {
            _loc2_ = RANDOM_FEMALE_FIGURES;
         }
         var _loc1_:int = Math.random() * (_loc2_.length - 1);
         return _loc2_[_loc1_];
      }
      
      private function populateThumbs() : void
      {
         _thumbs = new Dictionary();
         for each(var _loc2_ in CATEGORIES)
         {
            var _loc1_:Array = populateCategory(_loc2_);
            _thumbs[_loc2_] = null;
         }
         _thumbs["ea"] = populateCategory("ea");
         _thumbs["fa"] = populateCategory("fa");
         _thumbs["ha"] = populateCategory("ha");
      }
      
      private function populateColors() : void
      {
         var _loc10_:class_1780 = _context.avatarRenderManager.getFigureData();
         _colors = new Dictionary();
         var _loc8_:int = 16;
         var _loc4_:int = 12;
         var _loc1_:int = _loc8_ - _loc4_;
         for each(var _loc5_ in AvatarFigurePartType.FIGURE_SETS)
         {
            var _loc3_:ISetType = _loc10_.getSetType(_loc5_);
            var _loc6_:class_2017 = _loc10_.getPalette(null.paletteID);
            var _loc7_:Array = [];
            var _loc9_:Array = [];
            var _loc2_:Array = [];
            for each(var _loc11_ in null.colors)
            {
               if(_loc11_.isSelectable && null.length + null.length < _loc8_)
               {
                  null.push(createColorButton(_loc11_,_loc5_));
               }
            }
            null.sort(orderPaletteByIndex);
            null.sort(orderPaletteByIndex);
            _loc7_ = null.concat(null);
            _colors[_loc5_] = null;
         }
      }
      
      private function createColorButton(param1:IPartColor, param2:String) : ColorButton
      {
         var _loc3_:ColorButton = new ColorButton(0,0,colorSelected,16777215,param1.rgb);
         _loc3_.name = param2 + "_" + param1.id;
         _loc3_.setColor(param1.rgb);
         _loc3_.index = param1.index;
         _loc3_.club = param1.clubLevel > 0;
         return _loc3_;
      }
      
      private function orderPaletteByIndex(param1:ColorButton, param2:ColorButton) : Number
      {
         if(param1.index < param2.index)
         {
            return -1;
         }
         if(param1.index > param2.index)
         {
            return 1;
         }
         return 0;
      }
      
      private function colorSelected(param1:ColorButton) : void
      {
         var _loc3_:Array = null;
         var _loc8_:String = null;
         var _loc7_:Array = param1.name.split("_");
         var _loc6_:String = _loc7_[0];
         var _loc4_:String = _loc7_[1];
         var _loc9_:Array = [];
         _loc9_.push(_loc4_);
         for(var _loc5_ in var_403[var_111])
         {
            _loc8_ = var_403[var_111][_loc5_];
            _loc3_ = var_3368[_loc8_];
            if(_loc6_ == _loc5_)
            {
               _loc3_ = var_3368[_loc8_];
               if(_loc3_ && _loc3_.length > 1)
               {
                  _loc9_.push("25");
               }
            }
         }
         var_1426[var_111][_loc6_] = _loc9_;
         var _loc2_:ColorButton = _selectedColors[_loc6_];
         if(_loc2_)
         {
            _loc2_.unselect();
         }
         _selectedColors[_loc6_] = param1;
         param1.select();
         updateGrids(true);
         updateFigure();
      }
      
      private function renderColors() : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(var_1312.numChildren > 0)
         {
            var_1312.removeChildAt(0);
         }
         var _loc7_:Array = _colors[var_1844];
         if(_loc7_ == null)
         {
            return;
         }
         var _loc5_:int = 0;
         for each(var _loc1_ in _loc7_)
         {
            var_1312.addChild(_loc1_);
            _loc4_ = _loc5_ % 4;
            _loc6_ = _loc5_ / 4;
            _loc2_ = _loc4_ * 50 + _loc4_ * 2;
            _loc3_ = _loc6_ * 53 + _loc6_ * 10;
            _loc1_.x = _loc2_;
            _loc1_.y = _loc3_;
            _loc5_++;
         }
      }
      
      private function populateCategory(param1:String) : Array
      {
         var _loc14_:* = null;
         var _loc6_:Boolean = false;
         var _loc13_:int = 0;
         var _loc4_:Array = null;
         var _loc11_:Array = null;
         var _loc8_:int = 0;
         var _loc2_:IPartColor = null;
         var _loc9_:int = 0;
         var _loc12_:Array = [];
         var _loc16_:class_1780 = _context.avatarRenderManager.getFigureData();
         var _loc5_:ISetType = _loc16_.getSetType(param1);
         var _loc7_:class_2017 = _loc16_.getPalette(_loc5_.paletteID);
         var _loc3_:int = 0;
         if(_loc5_ && _loc7_)
         {
            for each(_loc14_ in _loc5_.partSets)
            {
               _loc6_ = true;
               if(_loc14_.clubLevel > 0)
               {
                  _loc6_ = _showHcItems;
               }
               if(_loc6_ && _loc14_.isPreSelectable && (_loc14_.gender == var_111 || _loc14_.gender == "U"))
               {
                  _loc13_ = 0;
                  for each(var _loc15_ in _loc14_.parts)
                  {
                     _loc13_ = Math.max(_loc13_,_loc15_.colorLayerIndex);
                  }
                  _loc4_ = [];
                  for each(var _loc10_ in _loc7_.colors)
                  {
                     if(_loc10_.isSelectable)
                     {
                        _loc4_.push(_loc10_);
                     }
                  }
                  _loc11_ = [];
                  if(_loc4_.length > 0)
                  {
                     _loc8_ = Math.random() * (_loc4_.length - 1);
                     _loc2_ = _loc4_[_loc8_];
                     _loc9_ = 0;
                     while(_loc9_ < _loc13_)
                     {
                        _loc9_++;
                     }
                  }
                  _loc12_.push([param1,_loc14_.id].concat(_loc11_).join("-"));
                  if(++_loc3_ == 5)
                  {
                     break;
                  }
               }
            }
         }
         return _loc12_;
      }
      
      private function getCurrentlySelectedItems() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < CATEGORIES.length)
         {
            _loc1_.push("" + var_403[var_111][CATEGORIES[_loc2_]]);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < EXTRA_CATEGORIES.length)
         {
            _loc1_.push("" + var_403[var_111][EXTRA_CATEGORIES[_loc2_]]);
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function updateSelections() : void
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc1_:Array = getCurrentlySelectedItems();
         for each(var _loc5_ in var_2987)
         {
            _loc3_ = _loc5_.name.split("_");
            _loc4_ = _loc3_[0];
            _loc2_ = _loc3_[1];
            if(_loc1_.indexOf(_loc2_) > -1)
            {
               _loc5_.select();
            }
            else
            {
               _loc5_.unselect();
            }
         }
      }
      
      private function gridClick(param1:Button) : void
      {
         var _loc4_:Array = param1.name.split("_");
         var _loc5_:String = _loc4_[0];
         var _loc3_:String = _loc4_[1];
         var _loc2_:Array = getCurrentlySelectedItems();
         if(var_354)
         {
            var_354.unselect();
         }
         var _loc6_:* = var_354 == param1;
         _loc6_ = _loc2_.indexOf(_loc3_) > -1;
         var_354 = param1;
         if(_loc5_ == "hd" || _loc5_ == "lg" || var_111 == "F" && _loc5_ == "ch")
         {
            _loc6_ = false;
         }
         var_1844 = _loc5_;
         if(_loc6_)
         {
            delete var_403[var_111][var_1844];
            var_354 = null;
         }
         else
         {
            var_403[var_111][var_1844] = _loc3_;
            var_354.select();
            var_354.currentlyEditing();
         }
         updateFigure();
         renderColors();
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc2_:class_1827 = null;
         var _loc3_:BitmapData = null;
         if(param1 == getFigure() || param1.replace("-25","") == getFigure())
         {
            _loc2_ = _context.avatarRenderManager.createAvatarImage(param1,"h");
            _loc2_.setDirection("full",4);
            _loc3_ = _loc2_.getImage("full",false);
            if(_loc3_)
            {
               _figureContainer.bitmapData = _loc3_;
            }
         }
         else
         {
            updateGrids(false);
         }
      }
      
      public function returnFromPayment() : void
      {
         HabboWebTools.closeWebPageAndRestoreClient();
         if(ExternalInterface.available)
         {
            ExternalInterface.call("NewUserReception.newUserCheckHcMembership");
         }
      }
      
      public function checkForHcMembership(param1:String) : void
      {
         var _loc2_:String = param1;
         if("OK" === _loc2_)
         {
            var_5192 = true;
            populateColors();
            if(var_5197)
            {
               var_5197.visible = false;
            }
         }
      }
      
      private function saveOutfit(param1:Button) : void
      {
         _context.communicationManager.connection.send(new class_3061(getFigure(),var_111.toLowerCase()));
         _context.submitName();
      }
      
      public function nameChangeCompleted(param1:Boolean = false) : void
      {
         _context.editorFinished();
      }
      
      public function showHideGrid(param1:Boolean = false) : void
      {
         var_608.visible = param1;
         var_1312.visible = param1;
         var_2070.visible = param1;
         var_2247.visible = param1;
         var_541.visible = param1;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function showHideButtons(param1:Boolean) : void
      {
         var_541.visible = param1;
      }
      
      public function onRandomize(param1:Button) : void
      {
         setRandomFigure();
      }
   }
}

