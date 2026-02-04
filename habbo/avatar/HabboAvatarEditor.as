package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.habbo.avatar.common.AvatarEditorGridColorItem;
   import com.sulake.habbo.avatar.common.AvatarEditorGridPartItem;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.ISideContentModel;
   import com.sulake.habbo.avatar.common.class_2582;
   import com.sulake.habbo.avatar.effects.EffectsModel;
   import com.sulake.habbo.avatar.events.AvatarUpdateEvent;
   import com.sulake.habbo.avatar.figuredata.FigureData;
   import com.sulake.habbo.avatar.generic.BodyModel;
   import com.sulake.habbo.avatar.head.HeadModel;
   import com.sulake.habbo.avatar.hotlooks.HotLooksModel;
   import com.sulake.habbo.avatar.legs.LegsModel;
   import com.sulake.habbo.avatar.nft.NftAvatarsModel;
   import com.sulake.habbo.avatar.structure.class_1780;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.avatar.structure.figure.class_2017;
   import com.sulake.habbo.avatar.torso.TorsoModel;
   import com.sulake.habbo.avatar.wardrobe.NftOutfit;
   import com.sulake.habbo.avatar.wardrobe.WardrobeModel;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   import package_127.class_3439;
   import package_177.class_3061;
   import package_45.SaveUserNftWardrobeMessageComposer;
   import package_45.class_3186;
   
   public class HabboAvatarEditor
   {
      
      public static const DEFAULT_MALE_FIGURE:String = "hr-100.hd-180-7.ch-215-66.lg-270-79.sh-305-62.ha-1002-70.wa-2007";
      
      public static const DEFAULT_FEMALE_FIGURE:String = "hr-515-33.hd-600-1.ch-635-70.lg-716-66-62.sh-735-68";
      
      private static const MAX_COLOR_LAYERS:int = 2;
      
      private var var_3637:uint;
      
      private var var_52:HabboAvatarEditorManager;
      
      private var var_1640:class_1780;
      
      private var var_18:AvatarEditorView;
      
      private var var_265:Boolean = false;
      
      private var var_143:class_55;
      
      private var var_1069:class_55;
      
      private var var_1181:Dictionary;
      
      private var var_111:String = "M";
      
      private var _figureString:String;
      
      private var var_1698:class_2071 = null;
      
      private var var_3149:Boolean = false;
      
      private var var_3312:Boolean = false;
      
      private var var_963:NftOutfit = null;
      
      private var var_1512:int;
      
      private var var_4187:Boolean = false;
      
      private var var_1956:class_3439;
      
      private var var_2045:String;
      
      private var var_3608:String = "hr-100.hd-180-7.ch-215-66.lg-270-79.sh-305-62.ha-1002-70.wa-2007";
      
      private var var_4944:String = "M";
      
      private var var_4621:String = "hr-100.hd-180-7.ch-215-66.lg-270-79.sh-305-62.ha-1002-70.wa-2007";
      
      private var var_5168:String = "M";
      
      public function HabboAvatarEditor(param1:uint, param2:HabboAvatarEditorManager, param3:Boolean = false)
      {
         super();
         var_3637 = param1;
         var_52 = param2;
         var_1640 = var_52.avatarRenderManager.getFigureData();
         var_4187 = param3;
      }
      
      public function dispose() : void
      {
         if(var_1956 != null)
         {
            var_52.communication.removeHabboConnectionMessageEvent(var_1956);
            var_1956 = null;
         }
         if(var_143 != null)
         {
            for each(var _loc2_ in var_143)
            {
               _loc2_.dispose();
               _loc2_ = null;
            }
            var_143 = null;
         }
         if(var_1069 != null)
         {
            for each(var _loc1_ in var_1069)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            var_1069 = null;
         }
         if(var_18 != null)
         {
            var_18.dispose();
            var_18 = null;
         }
         var_1640 = null;
         var_1181 = null;
         var_1698 = null;
      }
      
      private function init(param1:Array = null) : void
      {
         if(var_265)
         {
            return;
         }
         if(var_52.communication)
         {
            var_1956 = new class_3439(onUserNftWardrobeMessage);
            var_52.communication.addHabboConnectionMessageEvent(var_1956);
            sendGetSelectedNftWardrobeOutfitMessage();
         }
         var_143 = new class_55();
         var_1069 = new class_55();
         var_1069.add("wardrobe",new WardrobeModel(this));
         var_18 = new AvatarEditorView(this,param1);
         var_1181 = new Dictionary();
         var_1181["M"] = new FigureData(this);
         var_1181["F"] = new FigureData(this);
         var _loc3_:FigureData = var_1181["M"];
         var _loc2_:FigureData = var_1181["F"];
         _loc3_.loadAvatarData("hr-100.hd-180-7.ch-215-66.lg-270-79.sh-305-62.ha-1002-70.wa-2007","M");
         _loc2_.loadAvatarData("hr-515-33.hd-600-1.ch-635-70.lg-716-66-62.sh-735-68","F");
         var_143.add("generic",new BodyModel(this));
         var_143.add("head",new HeadModel(this));
         var_143.add("torso",new TorsoModel(this));
         var_143.add("legs",new LegsModel(this));
         if(param1 == null || param1.indexOf("hotlooks") > -1)
         {
            var_143.add("hotlooks",new HotLooksModel(this));
         }
         var_143.add("effects",new EffectsModel(this));
         var_143.add("nfts",new NftAvatarsModel(this));
         var_265 = true;
      }
      
      private function sendGetSelectedNftWardrobeOutfitMessage() : void
      {
         if(var_52.communication)
         {
            var_52.communication.connection.send(new class_3186());
         }
      }
      
      private function onUserNftWardrobeMessage(param1:class_3439) : void
      {
         var_2045 = param1.getParser().currentTokenId;
         var_3608 = param1.getParser().fallbackFigureString;
         var_4944 = param1.getParser().fallbackFigureGender;
         if(hasNftOutfit() && var_18.currentViewId != "nfts")
         {
            loadFallbackFigure();
         }
      }
      
      public function loadAvatarInEditor(param1:String, param2:String, param3:int = 0) : void
      {
         switch(param2)
         {
            case "M":
            case "m":
            case "M":
               param2 = "M";
               break;
            case "F":
            case "f":
            case "F":
               param2 = "F";
               break;
            default:
               param2 = "M";
         }
         this.clubMemberLevel = param3;
         var _loc5_:FigureData = var_1181[param2];
         if(_loc5_ == null)
         {
            return;
         }
         _loc5_.loadAvatarData(param1,param2);
         if(param2 != this.gender)
         {
            this.gender = param2;
            var _loc4_:Boolean = true;
         }
         if(_figureString != param1)
         {
            _figureString = param1;
            _loc4_ = true;
         }
         if(var_143 && false)
         {
            for each(var _loc6_ in var_143)
            {
               _loc6_.reset();
            }
         }
         if(var_18 != null)
         {
            var_18.update();
         }
      }
      
      public function getFigureSetType(param1:String) : ISetType
      {
         if(var_1640 == null)
         {
            return null;
         }
         return var_1640.getSetType(param1);
      }
      
      public function getPalette(param1:int) : class_2017
      {
         if(var_1640 == null)
         {
            return null;
         }
         return var_1640.getPalette(param1);
      }
      
      public function openWindow(param1:class_2071, param2:Array = null, param3:Boolean = false, param4:String = null, param5:String = "generic") : class_2250
      {
         var_1698 = param1;
         var_3149 = param3;
         init(param2);
         selectDefaultCategory(param2,param5);
         return var_18.getFrame(param2,param4);
      }
      
      public function embedToContext(param1:class_1812 = null, param2:class_2071 = null, param3:Array = null, param4:Boolean = false) : Boolean
      {
         var_1698 = param2;
         var_3149 = param4;
         init(param3);
         var_18.embedToContext(param1,param3);
         selectDefaultCategory(param3);
         return true;
      }
      
      private function selectDefaultCategory(param1:Array, param2:String = "generic") : void
      {
         var _loc3_:Boolean = param1 != null && param1.length > 0;
         if(param2 != null && (!_loc3_ || param1.indexOf(param2) >= 0))
         {
            toggleAvatarEditorPage(param2);
         }
         else if(_loc3_)
         {
            toggleAvatarEditorPage(param1[0]);
         }
         else
         {
            toggleAvatarEditorPage("generic");
         }
      }
      
      public function get instanceId() : uint
      {
         return var_3637;
      }
      
      public function hide() : void
      {
         var_18.hide();
      }
      
      public function getCategoryWindowContainer(param1:String) : class_1741
      {
         var _loc2_:class_2582 = var_143.getValue(param1) as class_2582;
         if(_loc2_ != null)
         {
            return _loc2_.getWindowContainer();
         }
         return null;
      }
      
      public function activateCategory(param1:String) : void
      {
         var _loc2_:class_2582 = var_143.getValue(param1) as class_2582;
         if(_loc2_)
         {
            _loc2_.switchCategory();
         }
      }
      
      public function getSideContentWindowContainer(param1:String) : class_1812
      {
         var _loc2_:ISideContentModel = var_1069.getValue(param1) as ISideContentModel;
         if(_loc2_ != null)
         {
            return _loc2_.getWindowContainer();
         }
         return null;
      }
      
      public function toggleAvatarEditorPage(param1:String) : void
      {
         if(var_18)
         {
            var_18.toggleCategoryView(param1,false);
         }
      }
      
      public function useClubClothing() : void
      {
         if(var_143 == null)
         {
            return;
         }
         update();
      }
      
      public function disableClubClothing() : void
      {
         if(var_143 == null)
         {
            return;
         }
         update();
      }
      
      public function get figureData() : FigureData
      {
         return var_1181[var_111];
      }
      
      public function saveCurrentSelection() : void
      {
         var _loc1_:String = figureData.getFigureString();
         var _loc2_:String = figureData.gender;
         if(var_1698 != null)
         {
            var_1698.saveFigure(_loc1_,_loc2_);
         }
         else
         {
            if(var_52.communication)
            {
               if(var_963 != null)
               {
                  var_52.communication.connection.send(new SaveUserNftWardrobeMessageComposer(var_963.id));
                  sendGetSelectedNftWardrobeOutfitMessage();
                  var_963 = null;
               }
               else
               {
                  var_52.communication.connection.send(new class_3061(_loc1_,_loc2_));
               }
            }
            if(hasNftOutfit())
            {
               var_2045 = null;
            }
            var_52.events.dispatchEvent(new AvatarUpdateEvent(_loc1_));
            if(var_3312)
            {
               if(figureData.avatarEffectType != -1)
               {
                  var_52.inventory.setEffectSelected(figureData.avatarEffectType);
               }
               else
               {
                  var_52.inventory.deselectAllEffects(true);
               }
            }
            var_3312 = false;
         }
      }
      
      public function generateDataContent(param1:class_2582, param2:String) : CategoryData
      {
         var _loc21_:int = 0;
         if(!param1)
         {
            return null;
         }
         if(!param2)
         {
            return null;
         }
         var _loc8_:Array = [];
         _loc21_ = 0;
         while(_loc21_ < 2)
         {
            _loc8_.push([]);
            _loc21_++;
         }
         var _loc22_:ISetType = getFigureSetType(param2);
         if(!_loc22_)
         {
            return null;
         }
         _loc4_.sort(showClubItemsFirst ? orderByClubDesc : orderByClubAsc);
         if(var_4187 || var_52.getBoolean("avatareditor.support.sellablefurni"))
         {
            var _loc20_:BitmapDataAsset = var_52.windowManager.assets.getAssetByName("camera_zoom_in") as BitmapDataAsset;
            var _loc23_:BitmapData = (_loc20_.content as BitmapData).clone();
            var _loc7_:class_1812 = AvatarEditorView.THUMB_WINDOW.clone() as class_1812;
            _loc7_.name = "GET_MORE";
            var _loc9_:AvatarEditorGridPartItem = new AvatarEditorGridPartItem(null,param1,null,null,false);
            _loc9_.iconImage = null;
            _loc4_.push(null);
         }
         _loc21_ = 0;
         while(_loc21_ < 2)
         {
            var _loc5_:Array = _loc8_[_loc21_] as Array;
            _loc5_.sort(orderPaletteByClub);
            _loc21_++;
         }
         return new CategoryData(_loc4_,_loc8_);
      }
      
      public function isSideContentEnabled() : Boolean
      {
         return var_3149;
      }
      
      public function hasInvalidClubItems() : Boolean
      {
         var _loc1_:Boolean = false;
         for each(var _loc2_ in var_143.getValues())
         {
            _loc1_ = _loc2_.hasClubItemsOverLevel(clubMemberLevel);
            if(_loc1_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function hasInvalidSellableItems() : Boolean
      {
         var _loc1_:Boolean = false;
         for each(var _loc2_ in var_143.getValues())
         {
            _loc1_ = _loc2_.hasInvalidSellableItems(var_52.inventory);
            if(_loc1_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function stripClubItems() : void
      {
         for each(var _loc1_ in var_143.getValues())
         {
            _loc1_.stripClubItemsOverLevel(clubMemberLevel);
         }
         figureData.updateView();
      }
      
      public function stripInvalidSellableItems() : void
      {
         for each(var _loc1_ in var_143.getValues())
         {
            _loc1_.stripInvalidSellableItems();
         }
         figureData.updateView();
      }
      
      public function getDefaultColour(param1:String) : int
      {
         var _loc2_:ISetType = getFigureSetType(param1);
         if(_loc2_ != null)
         {
            var _loc3_:class_2017 = getPalette(_loc2_.paletteID);
            for each(var _loc4_ in null.colors)
            {
               if(_loc4_.isSelectable && clubMemberLevel >= _loc4_.clubLevel)
               {
                  return _loc4_.id;
               }
            }
         }
         return -1;
      }
      
      private function orderByClubAsc(param1:AvatarEditorGridPartItem, param2:AvatarEditorGridPartItem) : Number
      {
         var _loc4_:Number = param1.partSet?.clubLevel;
         var _loc5_:Number = param2.partSet?.clubLevel;
         var _loc6_:Boolean = param1.partSet?.isSellable;
         var _loc3_:Boolean = param2.partSet?.isSellable;
         if(_loc6_ && !_loc3_)
         {
            return 1;
         }
         if(_loc3_ && !_loc6_)
         {
            return -1;
         }
         if(_loc4_ < _loc5_)
         {
            return -1;
         }
         if(_loc4_ > _loc5_)
         {
            return 1;
         }
         if(param1.partSet.id < param2.partSet.id)
         {
            return -1;
         }
         if(param1.partSet.id > param2.partSet.id)
         {
            return 1;
         }
         return 0;
      }
      
      private function orderByClubDesc(param1:AvatarEditorGridPartItem, param2:AvatarEditorGridPartItem) : Number
      {
         var _loc4_:Number = param1.partSet?.clubLevel;
         var _loc5_:Number = param2.partSet?.clubLevel;
         var _loc6_:Boolean = param1.partSet?.isSellable;
         var _loc3_:Boolean = param2.partSet?.isSellable;
         if(_loc6_ && !_loc3_)
         {
            return 1;
         }
         if(_loc3_ && !_loc6_)
         {
            return -1;
         }
         if(_loc4_ > _loc5_)
         {
            return -1;
         }
         if(_loc4_ < _loc5_)
         {
            return 1;
         }
         if(param1.partSet.id > param2.partSet.id)
         {
            return -1;
         }
         if(param1.partSet.id < param2.partSet.id)
         {
            return 1;
         }
         return 0;
      }
      
      private function orderPaletteByClub(param1:AvatarEditorGridColorItem, param2:AvatarEditorGridColorItem) : Number
      {
         var _loc3_:Number = param1.partColor == null ? -1 : param1.partColor.clubLevel as Number;
         var _loc4_:Number = param2.partColor == null ? -1 : param2.partColor.clubLevel as Number;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.partColor.index < param2.partColor.index)
         {
            return -1;
         }
         if(param1.partColor.index > param2.partColor.index)
         {
            return 1;
         }
         return 0;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function set gender(param1:String) : void
      {
         if(var_111 == param1)
         {
            return;
         }
         var_111 = param1;
         for each(var _loc2_ in var_143)
         {
            _loc2_.reset();
         }
         if(var_18 != null)
         {
            var_18.update();
         }
      }
      
      public function get handler() : AvatarEditorMessageHandler
      {
         return var_52.handler;
      }
      
      public function get wardrobe() : WardrobeModel
      {
         if(!var_265)
         {
            return null;
         }
         return var_1069.getValue("wardrobe");
      }
      
      public function get effects() : EffectsModel
      {
         if(!var_265)
         {
            return null;
         }
         return var_143.getValue("effects");
      }
      
      public function set clubMemberLevel(param1:int) : void
      {
         var_1512 = param1;
      }
      
      public function get clubMemberLevel() : int
      {
         if(!var_1512)
         {
            return var_52.sessionData.clubLevel;
         }
         return var_1512;
      }
      
      public function verifyClubLevel() : Boolean
      {
         return var_52.catalog.verifyClubLevel();
      }
      
      private function get showClubItemsFirst() : Boolean
      {
         return var_52.getBoolean("avatareditor.show.clubitems.first");
      }
      
      private function showClubItemsDimmedConfiguration() : Boolean
      {
         return var_52.getBoolean("avatareditor.show.clubitems.dimmed");
      }
      
      public function get manager() : HabboAvatarEditorManager
      {
         return var_52;
      }
      
      public function update() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         for each(_loc1_ in var_143)
         {
            _loc1_.reset();
         }
         for each(_loc2_ in var_1069)
         {
            _loc2_.reset();
         }
         if(var_18)
         {
            var_18.update();
         }
      }
      
      public function setAvatarEffectType(param1:int) : void
      {
         figureData.avatarEffectType = param1;
         figureData.updateView();
         var_3312 = true;
      }
      
      public function setNftOutfit(param1:NftOutfit) : void
      {
         var_963 = param1;
         var_4621 = figureData.getFigureString();
         var_5168 = figureData.gender;
      }
      
      public function hasSetNftOutfitInViewer() : Boolean
      {
         return var_963 != null;
      }
      
      public function loadNftFigure() : void
      {
         var _loc1_:NftAvatarsModel = null;
         var _loc2_:NftOutfit = null;
         if(var_963)
         {
            loadAvatarInEditor(var_963.figure,var_963.gender,var_1512);
         }
         else if(var_2045 != null)
         {
            _loc1_ = var_143.getValue("nfts");
            if(_loc1_)
            {
               _loc2_ = _loc1_.getNftAvatarByTokenId(var_2045);
               if(_loc2_)
               {
                  setNftOutfit(_loc2_);
                  loadAvatarInEditor(_loc2_.figure,_loc2_.gender,var_1512);
               }
            }
         }
      }
      
      public function loadRollbackFigure() : void
      {
         if(var_963)
         {
            loadAvatarInEditor(var_4621,var_5168,var_1512);
         }
      }
      
      public function loadFallbackFigure() : void
      {
         if(var_3608)
         {
            loadAvatarInEditor(var_3608,var_4944,var_1512);
         }
      }
      
      public function hasNftOutfit() : Boolean
      {
         return var_2045 != null;
      }
      
      public function get view() : AvatarEditorView
      {
         return var_18;
      }
      
      public function openHabboClubAdWindow() : void
      {
         if(var_52.catalog)
         {
            var_52.catalog.openClubCenter();
         }
      }
      
      public function isDevelopmentEditor() : Boolean
      {
         return var_3637 == 3;
      }
   }
}

