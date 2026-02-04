package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.class_1901;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.habbo.window.widgets.IRarityItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.class_2728;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class InfoStandPetView
   {
      
      private static const STATUS_BAR_WIDTH:int = 162;
      
      private static const STATUS_BAR_HEIGTH:int = 16;
      
      private static const STATUS_BAR_HIGHLIGHT_HEIGHT:int = 4;
      
      private static const STATUS_BAR_BORDER_COLOR:uint = 14342874;
      
      private static const STATUS_BAR_BG_COLOR:uint = 3815994;
      
      private static const STATUS_BAR_HAPPINESS_HIGHLIGHT_COLOR:uint = 2085362;
      
      private static const STATUS_BAR_HAPPINESS_CONTENT_COLOR:uint = 39616;
      
      private static const STATUS_BAR_EXPERIENCE_HIGHLIGHT_COLOR:uint = 10513106;
      
      private static const STATUS_BAR_EXPERIENCE_CONTENT_COLOR:uint = 8734654;
      
      private static const STATUS_BAR_ENERGY_HIGHLIGHT_COLOR:uint = 9094430;
      
      private static const STATUS_BAR_ENERGY_CONTENT_COLOR:uint = 6200576;
      
      private static const STATUS_BAR_WELLBEING_HIGHLIGHT_COLOR:uint = 9094430;
      
      private static const STATUS_BAR_WELLBEING_CONTENT_COLOR:uint = 6200576;
      
      private static const STATE_HAPPINESS:String = "happiness";
      
      private static const STATE_EXPERIENCE:String = "experience";
      
      private static const STATE_ENERGY:String = "energy";
      
      private static const STATE_WELLBEING:String = "wellbeing";
      
      private static const STATE_GROWTH:String = "growth";
      
      private static const BUTTONS_MAX_WIDTH:int = 250;
      
      private static const BUTTON_HEIGHT:int = 25;
      
      private static const BUTTON_MARGIN:int = 5;
      
      private var _catalog:IHabboCatalog;
      
      private var _habboTracking:class_53;
      
      private var var_16:InfoStandWidget;
      
      private var _window:IItemListWindow;
      
      private var var_31:class_1993;
      
      private var _buttonsContainer:class_1812;
      
      private var var_108:IItemListWindow;
      
      private var var_169:PetCommandTool;
      
      private var var_311:class_55;
      
      private var var_1412:int;
      
      public function InfoStandPetView(param1:InfoStandWidget, param2:String, param3:IHabboCatalog)
      {
         super();
         var_16 = param1;
         _catalog = param3;
         _habboTracking = HabboTracking.getInstance();
         createWindow(param2);
         var_311 = new class_55();
      }
      
      public function dispose() : void
      {
         var_16 = null;
         _catalog = null;
         _habboTracking = null;
         var_31 = null;
         _buttonsContainer = null;
         var_108 = null;
         if(_window)
         {
            _window.dispose();
         }
         _window = null;
         if(var_169)
         {
            var_169.dispose();
         }
         var_169 = null;
         if(var_311)
         {
            var_311.dispose();
            var_311 = null;
         }
      }
      
      public function get window() : IItemListWindow
      {
         return _window;
      }
      
      private function updateWindow() : void
      {
         if(var_108 == null || var_31 == null || _buttonsContainer == null)
         {
            return;
         }
         _buttonsContainer.width = _buttonsContainer.width;
         _buttonsContainer.visible = _buttonsContainer.width > 0;
         var_108.height = var_108.scrollableRegion.height;
         var_31.height = var_108.height + 20;
         _window.width = Math.max(var_31.width,_buttonsContainer.width);
         _window.height = _window.scrollableRegion.height;
         if(var_31.width < _buttonsContainer.width)
         {
            var_31.x = _window.width - var_31.width;
            _buttonsContainer.x = 0;
         }
         else
         {
            _buttonsContainer.x = _window.width - _buttonsContainer.width;
            var_31.x = 0;
         }
         var_16.refreshContainer();
      }
      
      public function updateImage(param1:int, param2:BitmapData) : void
      {
         if(var_1412 == param1)
         {
            image = param2;
            updateWindow();
            updatePetCommandToolImage(param2);
         }
      }
      
      private function updatePetCommandToolImage(param1:BitmapData) : void
      {
         if(var_169 != null)
         {
            var_169.updatePetImage(param1);
         }
      }
      
      public function update(param1:InfoStandPetData) : void
      {
         var _loc2_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         name = param1.name;
         image = param1.image;
         ownerName = param1.ownerName;
         breedText = var_16.localizations.getLocalization(getBreedLocalizationKey(param1.type,param1.breedId));
         updatePetRespect(param1.petRespect,param1.type != 16);
         ageText = param1.age;
         setLevelText(param1.level,param1.levelMax,param1.type != 16);
         setSpecialSkillLevel(param1.level,param1.skillTresholds,param1.type);
         setRarityLevel(param1.rarityLevel,param1.type);
         if(param1.type == 16)
         {
            showStatusContainer("default",false);
            showStatusContainer("monsterplant",true);
            var _loc3_:String = class_3965.formatSeconds(param1.remainingWellBeingSeconds);
            updateStateElement("wellbeing",param1.remainingWellBeingSeconds,param1.maxWellBeingSeconds,6200576,9094430,null);
            updateStateWidget("growth",param1.remainingGrowingSeconds);
            showButton("petrespect",false);
            if(param1.energy > 0)
            {
               _loc2_ = param1.energy as Number;
               _loc5_ = param1.energyMax as Number;
               showButton("pettreat",_loc2_ / _loc5_ < 0.98);
            }
            else
            {
               showButton("pettreat",false);
            }
            showButton("train",false);
            showButton("buy_food",false);
            showButton("kick",false);
            showButton("pick",param1.canRemovePet);
            showRarityItem(param1.rarityLevel >= 0,param1);
         }
         else
         {
            showStatusContainer("default",true);
            showStatusContainer("monsterplant",false);
            showButton("petrespect",true);
            showButton("pettreat",false);
            showButton("train",param1.isOwnPet);
            showButton("pick",param1.isOwnPet);
            showButton("buy_food",true);
            showButton("kick",param1.canRemovePet);
            updateStateElement("happiness",param1.nutrition,param1.nutritionMax,39616,2085362);
            updateStateElement("experience",param1.experience,param1.experienceMax,8734654,10513106);
            updateStateElement("energy",param1.energy,param1.energyMax,6200576,9094430);
            updateRespectButton();
         }
         showButton("move",param1.isOwnPet && param1.type == 16);
         showButton("rotate",param1.isOwnPet && param1.type == 16);
         updateWindow();
         var_1412 = param1.id;
         var_311.remove(param1.id);
         var_311.add(param1.id,param1);
         if(var_169 && var_169.isVisible() && param1.isOwnPet)
         {
            var _loc6_:int = getLowerSkillTreshold(param1.level,param1.skillTresholds);
            _loc4_ = param1.experience / param1.experienceMax;
            var_169.showCommandToolForPet(param1.id,param1.name,param1.image,param1.type,param1.level - 0,_loc4_,getUpperSkillTreshold(param1.level,param1.skillTresholds) - 0,param1.skillTresholds);
         }
      }
      
      private function setRarityLevel(param1:int, param2:int) : void
      {
         var _loc6_:Array = [16,26];
         var _loc5_:String = param2 != 16 ? "default" : "monsterplant";
         var _loc3_:IItemListWindow = getStatusContainer(_loc5_);
         var _loc4_:ITextWindow = _loc3_.getListItemByName("status_rarity_level") as ITextWindow;
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.visible = _loc6_.indexOf(param2) > -1;
         var_16.localizations.registerParameter("infostand.pet.text.raritylevel","level",var_16.localizations.getLocalization("infostand.pet.raritylevel." + param1));
         updateWindow();
      }
      
      public function getCurrentPetId() : int
      {
         return var_1412;
      }
      
      public function updateEnabledTrainingCommands(param1:int, param2:CommandConfiguration) : void
      {
         if(var_169 == null)
         {
            return;
         }
         var_169.setEnabledCommands(param1,param2);
      }
      
      private function getBreedLocalizationKey(param1:int, param2:int) : String
      {
         return "pet.breed." + param1 + "." + param2;
      }
      
      private function createPercentageBar(param1:int, param2:int, param3:uint, param4:uint) : BitmapData
      {
         param2 = Math.max(param2,1);
         param1 = Math.max(param1,0);
         if(param1 > param2)
         {
            param1 = param2;
         }
         var _loc10_:Number = param1 / param2;
         var _loc7_:BitmapData = new BitmapData(162,16,false);
         _loc7_.fillRect(new Rectangle(0,0,_loc7_.width,_loc7_.height),14342874);
         var _loc8_:Rectangle = new Rectangle(1,1,_loc7_.width - 1 * 2,_loc7_.height - 1 * 2);
         _loc7_.fillRect(_loc8_,3815994);
         var _loc6_:Rectangle = new Rectangle(1,1 + 4,_loc7_.width - 1 * 2,_loc7_.height - 1 * 2 - 4);
         _loc6_.width = _loc10_ * _loc6_.width;
         _loc7_.fillRect(_loc6_,param3);
         var _loc5_:Rectangle = new Rectangle(1,1,_loc7_.width - 1 * 2,4);
         _loc5_.width = _loc10_ * _loc5_.width;
         _loc7_.fillRect(_loc5_,param4);
         return _loc7_;
      }
      
      public function openTrainView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Number = NaN;
         if(var_169 == null)
         {
            var_169 = new PetCommandTool(var_16);
         }
         var _loc1_:InfoStandPetData = var_311.getValue(var_1412) as InfoStandPetData;
         if(_loc1_ != null)
         {
            var_169.showWindow(true);
            _loc3_ = getLowerSkillTreshold(_loc1_.level,_loc1_.skillTresholds);
            _loc2_ = _loc1_.experience / _loc1_.experienceMax;
            var_169.showCommandToolForPet(_loc1_.id,_loc1_.name,_loc1_.image,_loc1_.type,_loc1_.level - _loc3_,_loc2_,getUpperSkillTreshold(_loc1_.level,_loc1_.skillTresholds) - _loc3_,_loc1_.skillTresholds);
         }
      }
      
      public function closeTrainView() : void
      {
         if(var_169 && var_169.getPetId() == var_1412)
         {
            var_169.showWindow(false);
         }
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc18_:XmlAsset = var_16.assets.getAssetByName("pet_view") as XmlAsset;
         _window = var_16.windowManager.buildFromXML(_loc18_.content as XML) as IItemListWindow;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var_31 = _window.getListItemByName("info_border") as class_1993;
         if(var_31 != null)
         {
            var_108 = var_31.findChildByName("infostand_element_list") as IItemListWindow;
         }
         _window.name = param1;
         var_16.mainContainer.addChild(_window);
         var _loc16_:class_1741 = var_31.findChildByTag("close");
         if(_loc16_ != null)
         {
            _loc16_.addEventListener("WME_CLICK",onClose);
         }
         _buttonsContainer = _window.getListItemByName("button_list") as class_1812;
         if(_buttonsContainer == null)
         {
            return;
         }
         var _loc6_:Array = [];
         _buttonsContainer.groupChildrenWithTag("CMD_BUTTON",_loc6_,-1);
         for each(var _loc15_ in _loc6_)
         {
            _loc15_.addEventListener("WME_CLICK",onButtonClicked);
         }
         var _loc19_:class_2251 = var_31.findChildByName("petrespect_icon") as class_2251;
         if(_loc19_ != null)
         {
            var _loc22_:BitmapDataAsset = var_16.assets.getAssetByName("icon_petrespect") as BitmapDataAsset;
            var _loc20_:BitmapData = _loc22_.content as BitmapData;
            _loc19_.bitmap = null.clone();
         }
         var _loc24_:class_2251 = var_31.findChildByName("status_happiness_icon") as class_2251;
         if(_loc24_ != null)
         {
            var _loc14_:BitmapDataAsset = var_16.assets.getAssetByName("icon_pet_happiness") as BitmapDataAsset;
            var _loc9_:BitmapData = _loc14_.content as BitmapData;
            _loc24_.bitmap = null.clone();
         }
         var _loc17_:class_2251 = var_31.findChildByName("status_experience_icon") as class_2251;
         if(_loc17_ != null)
         {
            var _loc2_:BitmapDataAsset = var_16.assets.getAssetByName("icon_pet_experience") as BitmapDataAsset;
            var _loc4_:BitmapData = null.content as BitmapData;
            _loc17_.bitmap = null.clone();
         }
         var _loc21_:class_2251 = var_31.findChildByName("status_energy_icon") as class_2251;
         if(_loc21_ != null)
         {
            var _loc11_:BitmapDataAsset = var_16.assets.getAssetByName("icon_pet_energy") as BitmapDataAsset;
            var _loc3_:BitmapData = _loc11_.content as BitmapData;
            _loc21_.bitmap = null.clone();
         }
         var _loc13_:class_2251 = var_31.findChildByName("skill_level_indicator") as class_2251;
         if(_loc13_ != null)
         {
            var _loc10_:BitmapDataAsset = var_16.assets.getAssetByName("pet_skill_level_0") as BitmapDataAsset;
            var _loc7_:BitmapData = _loc10_.content as BitmapData;
            _loc13_.bitmap = null.clone();
         }
         var _loc12_:class_2251 = var_31.findChildByName("status_wellbeing_icon") as class_2251;
         if(_loc12_ != null)
         {
            var _loc8_:BitmapDataAsset = var_16.assets.getAssetByName("icon_pet_wellbeing") as BitmapDataAsset;
            var _loc5_:BitmapData = _loc8_.content as BitmapData;
            _loc12_.bitmap = null.clone();
         }
         for each(var _loc23_ in _loc6_)
         {
            if(_loc23_.parent)
            {
               _loc23_.parent.width = _loc23_.width;
            }
            _loc23_.addEventListener("WE_RESIZED",onButtonResized);
         }
      }
      
      private function set name(param1:String) : void
      {
         if(var_108 == null)
         {
            return;
         }
         var _loc2_:ITextWindow = var_108.getListItemByName("name_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         _loc2_.visible = true;
      }
      
      private function set image(param1:BitmapData) : void
      {
         if(var_108 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_1812 = var_108.getListItemByName("image_container") as class_1812;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:class_2251 = _loc2_.findChildByName("avatar_image") as class_2251;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:BitmapData = new BitmapData(_loc4_.width,_loc4_.height,true,0);
         var _loc5_:Point = new Point(0,0);
         _loc5_.x = Math.round((_loc4_.width - param1.width) / 2);
         _loc5_.y = Math.round((_loc4_.height - param1.height) / 2);
         _loc3_.copyPixels(param1,param1.rect,_loc5_);
         _loc4_.bitmap = _loc3_;
         _loc4_.invalidate();
         updateWindow();
      }
      
      private function setLevelText(param1:int, param2:int, param3:Boolean = true) : void
      {
         if(var_108 == null)
         {
            return;
         }
         var _loc5_:class_1812 = var_108.getListItemByName("image_container") as class_1812;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc4_:ITextWindow = _loc5_.findChildByName("level_text") as ITextWindow;
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.visible = param3;
         var_16.localizations.registerParameter("pet.level","level",param1.toString());
         var_16.localizations.registerParameter("pet.level","maxlevel",param2.toString());
         updateWindow();
      }
      
      private function setSpecialSkillLevel(param1:int, param2:Array, param3:int) : void
      {
         var _loc9_:int = 0;
         var _loc10_:BitmapDataAsset = null;
         var _loc6_:BitmapData = null;
         if(var_108 == null)
         {
            return;
         }
         var _loc4_:class_1812 = var_108.getListItemByName("image_container") as class_1812;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:class_1741 = _loc4_.findChildByName("status_skill_text");
         _loc5_.visible = var_16.config.getBoolean("pet.enhancements.enabled") && param3 == 15;
         var _loc7_:ITextWindow = _loc4_.findChildByName("status_skill_text") as ITextWindow;
         if(_loc7_ != null)
         {
            _loc7_.caption = "${infostand.pet.text.skill." + param3 + "}";
         }
         var _loc8_:class_2251 = _loc4_.findChildByName("skill_level_indicator") as class_2251;
         if(_loc8_ != null)
         {
            _loc8_.visible = var_16.config.getBoolean("pet.enhancements.enabled") && param3 == 15;
            _loc9_ = getSkillLevelIndex(param1,param2);
            _loc10_ = var_16.assets.getAssetByName("pet_skill_level_" + _loc9_) as BitmapDataAsset;
            _loc6_ = _loc10_.content as BitmapData;
            _loc8_.bitmap = _loc6_.clone();
         }
         updateWindow();
      }
      
      private function set ownerName(param1:String) : void
      {
         var_16.localizations.registerParameter("infostand.text.petowner","name",param1);
         updateWindow();
      }
      
      private function set breedText(param1:String) : void
      {
         if(var_108 == null)
         {
            return;
         }
         var _loc2_:ITextWindow = var_108.getListItemByName("breed_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         updateWindow();
      }
      
      private function set ageText(param1:int) : void
      {
         if(var_108 == null)
         {
            return;
         }
         var _loc2_:ITextWindow = var_108.getListItemByName("age_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var_16.localizations.registerParameter("pet.age","age",param1.toString());
         updateWindow();
      }
      
      private function updatePetRespect(param1:int, param2:Boolean) : void
      {
         var_16.localizations.registerParameter("infostand.text.petrespect","count",param1.toString());
         if(var_108 == null)
         {
            return;
         }
         var _loc5_:class_1812 = var_108.getListItemByName("petrespect_container") as class_1812;
         var _loc3_:ITextWindow = _loc5_.findChildByName("petrespect_text") as ITextWindow;
         var _loc4_:class_2251 = _loc5_.findChildByName("petrespect_icon") as class_2251;
         _loc3_.visible = param2;
         _loc4_.visible = param2;
         _loc4_.x = _loc3_.x + _loc3_.width + 2;
         updateWindow();
      }
      
      private function showStatusContainer(param1:String, param2:Boolean) : void
      {
         var _loc3_:IItemListWindow = getStatusContainer(param1);
         if(_loc3_ != null)
         {
            _loc3_.visible = param2;
         }
      }
      
      private function getStatusContainer(param1:String) : IItemListWindow
      {
         if(var_108 == null)
         {
            return null;
         }
         var _loc2_:class_1812 = var_108.getListItemByName("status_container") as class_1812;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.findChildByName("status_item_list_" + param1) as IItemListWindow;
      }
      
      private function updateStateWidget(param1:String, param2:int) : void
      {
         var _loc6_:* = false;
         var _loc9_:* = false;
         var _loc8_:ITextWindow = null;
         var _loc7_:IItemListWindow = null;
         if(var_108 == null)
         {
            return;
         }
         var _loc3_:class_1812 = var_108.getListItemByName("status_container") as class_1812;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:class_2010 = _loc3_.findChildByName(param1 + "_status_widget") as class_2010;
         var _loc5_:class_1901 = _loc4_.widget;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc10_:String = param1;
         if("growth" === _loc10_)
         {
            (_loc5_ as class_2728).seconds = param2;
            _loc6_ = param2 > 0;
            _loc9_ = _loc4_.visible != _loc6_;
            _loc4_.visible = _loc6_;
            _loc8_ = _loc3_.findChildByName(param1 + "_status_text") as ITextWindow;
            if(_loc8_ != null)
            {
               _loc8_.visible = _loc6_;
            }
            if(_loc9_)
            {
               _loc7_ = _loc3_.findChildByName("status_item_list_monsterplant") as IItemListWindow;
               if(_loc7_ != null)
               {
                  _loc7_.arrangeListItems();
               }
            }
         }
      }
      
      private function updateStateElement(param1:String, param2:int, param3:int, param4:uint, param5:uint, param6:String = null) : void
      {
         if(var_108 == null)
         {
            return;
         }
         var _loc7_:class_1812 = var_108.getListItemByName("status_container") as class_1812;
         if(_loc7_ == null)
         {
            return;
         }
         var _loc10_:ITextWindow = _loc7_.findChildByName("status_" + param1 + "_value_text") as ITextWindow;
         if(_loc10_ != null)
         {
            _loc10_.text = param6 ?? param2 + "/" + param3;
         }
         var _loc9_:class_2251 = _loc7_.findChildByName("status_" + param1 + "_bitmap") as class_2251;
         if(_loc9_ != null)
         {
            var _loc8_:BitmapData = createPercentageBar(param2,param3,param4,param5);
            if(_loc8_ != null)
            {
               _loc9_.bitmap = null;
               _loc9_.width = null.width;
               _loc9_.height = null.height;
               _loc9_.invalidate();
            }
         }
         updateWindow();
      }
      
      protected function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc5_:RoomWidgetMessage = null;
         var _loc6_:String = null;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:class_1741 = param1.target as class_1741;
         switch(_loc2_.name)
         {
            case "btn_move":
               _loc6_ = "RWFAM_MOVE";
               break;
            case "btn_rotate":
               _loc6_ = "RWFUAM_ROTATE";
               break;
            case "btn_pick":
               _loc6_ = "RWUAM_PICKUP_PET";
               if(var_169 && var_169.getPetId() == var_1412)
               {
                  var_169.showWindow(false);
               }
               break;
            case "btn_kick":
               _loc6_ = "RWUAM_PICKUP_PET";
               if(var_169 && var_169.getPetId() == var_1412)
               {
                  var_169.showWindow(false);
               }
               break;
            case "btn_train":
               openTrainView();
               break;
            case "btn_buy_food":
               if(_catalog)
               {
                  _catalog.openCatalogPage("pet_accessories");
                  if(_habboTracking && !_habboTracking.disposed)
                  {
                     _habboTracking.trackGoogle("infostandBuyPetFoodButton","click");
                  }
               }
               break;
            case "btn_petrespect":
               var_16.userData.petRespectLeft -= 1;
               updateRespectButton();
               _loc6_ = " RWUAM_RESPECT_PET";
               break;
            case "btn_pettreat":
               _loc6_ = "RWUAM_TREAT_PET";
         }
         if(_loc6_ != null)
         {
            if(_loc6_ == "RWFAM_MOVE" || _loc6_ == "RWFUAM_ROTATE")
            {
               _loc4_ = var_16.petData.roomIndex;
               _loc7_ = 100;
               _loc5_ = new RoomWidgetFurniActionMessage(_loc6_,_loc4_,_loc7_,-1,null);
               var_16.messageListener.processWidgetMessage(_loc5_);
            }
            else
            {
               _loc8_ = var_16.petData.id;
               _loc5_ = new RoomWidgetUserActionMessage(_loc6_,_loc8_);
               var_16.messageListener.processWidgetMessage(_loc5_);
            }
         }
         updateWindow();
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         var_16.close();
      }
      
      private function updateRespectButton() : void
      {
         var _loc1_:int = var_16.userData.petRespectLeft;
         var_16.localizations.registerParameter("infostand.button.petrespect","count",_loc1_.toString());
         showButton("petrespect",_loc1_ > 0);
      }
      
      protected function showButton(param1:String, param2:Boolean) : void
      {
         if(_buttonsContainer == null)
         {
            return;
         }
         var _loc3_:class_1741 = _buttonsContainer.getChildByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.visible = param2;
            arrangeButtons();
         }
      }
      
      protected function onButtonResized(param1:class_1758) : void
      {
         var _loc2_:class_1741 = param1.window.parent;
         if(_loc2_ && _loc2_.tags.indexOf("CMD_BUTTON_REGION") > -1)
         {
            _loc2_.width = param1.window.width;
         }
      }
      
      private function arrangeButtons() : void
      {
         _buttonsContainer.width = 250;
         var _loc2_:Array = [];
         _buttonsContainer.groupChildrenWithTag("CMD_BUTTON_REGION",_loc2_,-1);
         for each(var _loc4_ in _loc2_)
         {
            if(_loc4_.visible)
            {
               if(250 - _loc4_.width < 0)
               {
                  var _loc1_:int = 250;
                  var _loc3_:int = 0 + (25 + 5);
               }
               _loc4_.x = 250 - _loc4_.width;
               _loc4_.y = 0;
               _loc1_ = _loc4_.x - 5;
            }
         }
         _buttonsContainer.height = 0 + 25;
         updateWindow();
      }
      
      private function getSkillLevelIndex(param1:int, param2:Array) : int
      {
         var _loc3_:int = 0;
         for each(var _loc4_ in param2)
         {
            if(_loc4_ > 0 && param1 >= _loc4_)
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      private function getLowerSkillTreshold(param1:int, param2:Array) : int
      {
         var _loc3_:int = 0;
         for each(var _loc4_ in param2)
         {
            if(_loc4_ > param1)
            {
               break;
            }
            _loc3_ = _loc4_;
         }
         return _loc3_;
      }
      
      private function getUpperSkillTreshold(param1:int, param2:Array) : int
      {
         var _loc5_:int = getLowerSkillTreshold(param1,param2);
         var _loc4_:int = int(param2.indexOf(_loc5_));
         var _loc3_:int = _loc5_;
         if(_loc4_ < param2.length - 1)
         {
            _loc3_ = int(param2[_loc4_ + 1]);
         }
         return _loc3_;
      }
      
      private function showRarityItem(param1:Boolean, param2:InfoStandPetData) : void
      {
         if(var_108 == null)
         {
            return;
         }
         var _loc3_:class_1812 = var_108.getListItemByName("status_container") as class_1812;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:class_2010 = _loc3_.findChildByName("rarity_item_overlay_widget") as class_2010;
         var _loc6_:class_1901 = _loc4_.widget;
         if(_loc6_ == null)
         {
            return;
         }
         var _loc5_:IRarityItemPreviewOverlayWidget = IRarityItemPreviewOverlayWidget(_loc6_);
         _loc5_.rarityLevel = param2.rarityLevel;
      }
   }
}

