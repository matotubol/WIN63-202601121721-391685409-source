package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.avatar.actions.ActionDefinition;
   import com.sulake.habbo.avatar.actions.ActiveActionData;
   import com.sulake.habbo.avatar.actions.class_2501;
   import com.sulake.habbo.avatar.actions.class_2768;
   import com.sulake.habbo.avatar.alias.AssetAliasCollection;
   import com.sulake.habbo.avatar.animation.Animation;
   import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
   import com.sulake.habbo.avatar.animation.class_2314;
   import com.sulake.habbo.avatar.animation.class_2792;
   import com.sulake.habbo.avatar.cache.AvatarImageCache;
   import com.sulake.habbo.avatar.structure.AvatarCanvas;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.utils.class_2495;
   import flash.display.BitmapData;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class AvatarImage implements class_1827, class_13, class_1828
   {
      
      private static const CHANNELS_EQUAL:String = "CHANNELS_EQUAL";
      
      private static const CHANNELS_UNIQUE:String = "CHANNELS_UNIQUE";
      
      private static const CHANNELS_RED:String = "CHANNELS_RED";
      
      private static const CHANNELS_GREEN:String = "CHANNELS_GREEN";
      
      private static const CHANNELS_BLUE:String = "CHANNELS_BLUE";
      
      private static const CHANNELS_SATURATED:String = "CHANNELS_SATURATED";
      
      private static const DEFAULT_ACTION:String = "Default";
      
      private static const DEFAULT_DIR:int = 2;
      
      private static const DEFAULT_AVATAR_SET:String = "full";
      
      private static const MAX_IDLE_FRAMES:* = 8;
      
      private static const MAX_OTHER_FRAMES:* = 4;
      
      private static const DEFAULT_POINT:Point = new Point(0,0);
      
      protected var var_74:AvatarStructure;
      
      protected var var_337:String;
      
      protected var var_658:int;
      
      protected var _headDirection:int;
      
      protected var var_183:class_2501;
      
      protected var var_1134:Boolean;
      
      protected var var_721:Array = [];
      
      protected var _assets:AssetAliasCollection;
      
      protected var _cache:AvatarImageCache;
      
      protected var var_975:AvatarFigureContainer;
      
      protected var var_597:class_2792;
      
      protected var var_289:Array = [];
      
      protected var var_48:BitmapData;
      
      private var _defaultAction:class_2501;
      
      private var var_1679:class_2501;
      
      private var var_380:int = 0;
      
      private var _directionOffset:int = 0;
      
      private var var_247:Boolean;
      
      private var var_170:Vector.<ISpriteDataContainer>;
      
      private var var_652:Boolean;
      
      private var var_2180:Boolean = false;
      
      private var var_1114:Boolean = false;
      
      private var var_446:Array;
      
      private var var_1064:String;
      
      private var var_494:String;
      
      private var _fullImageCache:class_55;
      
      protected var var_1100:Boolean = false;
      
      private var _useFullImageCache:Boolean;
      
      private var var_2188:int = -1;
      
      private var var_4490:int;
      
      private var var_2017:Array = [];
      
      private var var_2802:int = -1;
      
      private var var_3167:String = null;
      
      private var var_3272:String = null;
      
      private var var_3528:EffectAssetDownloadManager;
      
      private var var_3529:class_1828;
      
      public function AvatarImage(param1:AvatarStructure, param2:AssetAliasCollection, param3:AvatarFigureContainer, param4:String, param5:EffectAssetDownloadManager, param6:class_1828)
      {
         super();
         var_247 = true;
         var_3528 = param5;
         var_74 = param1;
         _assets = param2;
         var_337 = param4;
         var_3529 = param6;
         var _loc7_:Boolean = false;
         if(var_337 == null)
         {
            var_337 = "h";
         }
         else if(var_337 == "h_50")
         {
            _loc7_ = true;
            var_337 = "sh";
         }
         if(param3 == null)
         {
            param3 = new AvatarFigureContainer("hr-893-45.hd-180-2.ch-210-66.lg-270-82.sh-300-91.wa-2007-.ri-1-");
            class_21.log("Using default avatar figure");
         }
         var_975 = param3;
         _cache = new AvatarImageCache(var_74,this,_assets,var_337,_loc7_);
         setDirection("full",2);
         var_289 = [];
         _defaultAction = new ActiveActionData("std");
         _defaultAction.definition = var_74.getDefaultActionDefinition();
         var_1679 = new ActiveActionData("lay");
         var_1679.definition = var_74.getDefaultLayActionDefinition();
         resetActions();
         _fullImageCache = new class_55();
      }
      
      public function getServerRenderData() : Array
      {
         getAvatarPartsForCamera("full");
         return _cache.getServerRenderData();
      }
      
      public function dispose() : void
      {
         if(!var_1134)
         {
            var_74 = null;
            _assets = null;
            var_183 = null;
            var_975 = null;
            var_597 = null;
            var_289 = null;
            if(var_48)
            {
               var_48.dispose();
            }
            if(_cache)
            {
               _cache.dispose();
               _cache = null;
            }
            if(_fullImageCache)
            {
               for each(var _loc1_ in _fullImageCache)
               {
                  _loc1_.dispose();
               }
               _fullImageCache.dispose();
               _fullImageCache = null;
            }
            var_48 = null;
            var_721 = null;
            var_1134 = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function getFigure() : class_1900
      {
         return var_975;
      }
      
      public function getScale() : String
      {
         return var_337;
      }
      
      public function getPartColor(param1:String) : IPartColor
      {
         return var_74.getPartColor(var_975,param1);
      }
      
      public function setDirection(param1:String, param2:int) : void
      {
         param2 += _directionOffset;
         if(param2 < 0)
         {
            param2 = 7 + (param2 + 1);
         }
         if(param2 > 7)
         {
            param2 -= 7 + 1;
         }
         if(var_74.isMainAvatarSet(param1))
         {
            var_658 = param2;
         }
         if(param1 == "head" || param1 == "full")
         {
            if(param1 == "head" && isHeadTurnPreventedByAction())
            {
               param2 = var_658;
            }
            _headDirection = param2;
         }
         _cache.setDirection(param1,param2);
         var_247 = true;
      }
      
      public function setDirectionAngle(param1:String, param2:int) : void
      {
         var _loc3_:int = 0;
         _loc3_ = param2 / 45;
         setDirection(param1,_loc3_);
      }
      
      public function getSprites() : Vector.<ISpriteDataContainer>
      {
         return var_170;
      }
      
      public function getCanvasOffsets() : Array
      {
         return var_721;
      }
      
      public function getLayerData(param1:ISpriteDataContainer) : class_2314
      {
         return var_74.getBodyPartData(param1.animation.id,var_380,param1.id);
      }
      
      public function updateAnimationByFrames(param1:int = 1) : void
      {
         var_380 += param1;
         var_247 = true;
      }
      
      public function resetAnimationFrameCounter() : void
      {
         var_380 = 0;
         var_247 = true;
      }
      
      private function getFullImageCacheKey() : String
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         if(!_useFullImageCache)
         {
            return null;
         }
         if(var_446.length == 1 && var_658 == _headDirection)
         {
            if(var_494 == "std" || var_494 == "lay" || var_494 == "sit")
            {
               _loc2_ = var_380 % 8;
            }
            else
            {
               _loc2_ = var_380 % 4;
            }
            return var_658 + var_494 + _loc2_;
         }
         if(var_446.length == 2)
         {
            for each(_loc1_ in var_446)
            {
               if(_loc1_.actionType == "fx" && (_loc1_.actionParameter == "33" || _loc1_.actionParameter == "34" || _loc1_.actionParameter == "35" || _loc1_.actionParameter == "36"))
               {
                  return var_658 + var_494 + 0;
               }
               if(_loc1_.actionType == "fx" && (_loc1_.actionParameter == "38" || _loc1_.actionParameter == "39"))
               {
                  _loc3_ = var_380 % 11;
                  return var_658 + "_" + _headDirection + var_494 + _loc3_;
               }
            }
         }
         return null;
      }
      
      private function getBodyParts(param1:String, param2:String, param3:int) : Array
      {
         if(param3 != var_2802 || param2 != var_3167 || param1 != var_3272)
         {
            var_2802 = param3;
            var_3167 = param2;
            var_3272 = param1;
            var_2017 = var_74.getBodyParts(param1,param2,param3);
         }
         return var_2017;
      }
      
      public function getAvatarPartsForCamera(param1:String) : void
      {
         var _loc4_:String = null;
         var _loc2_:AvatarImageBodyPartContainer = null;
         var _loc6_:int = 0;
         if(var_183 == null)
         {
            return;
         }
         var _loc5_:AvatarCanvas = var_74.getCanvas(var_337,var_183.definition.geometryType);
         if(_loc5_ == null)
         {
            return;
         }
         var _loc3_:Array = getBodyParts(param1,var_183.definition.geometryType,var_658);
         _loc6_ = _loc3_.length - 1;
         while(_loc6_ >= 0)
         {
            _loc4_ = _loc3_[_loc6_];
            _loc2_ = _cache.getImageContainer(_loc4_,var_380,true);
            _loc6_--;
         }
      }
      
      public function getImage(param1:String, param2:Boolean, param3:Number = 1) : BitmapData
      {
         var _loc12_:String = null;
         var _loc4_:AvatarImageBodyPartContainer = null;
         var _loc10_:BitmapData = null;
         var _loc8_:Point = null;
         var _loc11_:int = 0;
         if(!var_247)
         {
            return var_48;
         }
         if(var_183 == null)
         {
            return null;
         }
         if(!var_1114)
         {
            endActionAppends();
         }
         var _loc9_:String = getFullImageCacheKey();
         if(_loc9_ != null)
         {
            if(getFullImage(_loc9_))
            {
               var_247 = false;
               if(param2)
               {
                  return (getFullImage(_loc9_) as BitmapData).clone();
               }
               var_48 = getFullImage(_loc9_) as BitmapData;
               var_1100 = true;
               return var_48;
            }
         }
         var _loc6_:AvatarCanvas = var_74.getCanvas(var_337,var_183.definition.geometryType);
         if(_loc6_ == null)
         {
            return null;
         }
         if(var_1100 || var_48 == null || (var_48.width != _loc6_.width || var_48.height != _loc6_.height))
         {
            if(var_48 != null && !var_1100)
            {
               var_48.dispose();
            }
            var_48 = new BitmapData(_loc6_.width,_loc6_.height,true,0);
            var_1100 = false;
         }
         var _loc5_:Array = getBodyParts(param1,var_183.definition.geometryType,var_658);
         var_48.lock();
         var_48.fillRect(var_48.rect,0);
         var _loc13_:Boolean = true;
         _loc11_ = _loc5_.length - 1;
         while(_loc11_ >= 0)
         {
            _loc12_ = _loc5_[_loc11_];
            _loc4_ = _cache.getImageContainer(_loc12_,var_380);
            if(_loc4_)
            {
               _loc13_ &&= _loc4_.isCacheable;
               _loc10_ = _loc4_.image;
               _loc8_ = _loc4_.regPoint.add(_loc6_.offset);
               if(_loc10_ && _loc8_)
               {
                  _loc8_ = _loc8_.add(_loc6_.regPoint);
                  var_48.copyPixels(_loc10_,_loc10_.rect,_loc8_,null,null,true);
               }
            }
            _loc11_--;
         }
         var_48.unlock();
         var_247 = false;
         if(var_597 != null)
         {
            if(var_597.paletteIsGrayscale)
            {
               var _loc7_:BitmapData = convertToGrayscale(var_48);
               if(var_48)
               {
                  var_48.dispose();
               }
               var_48 = null;
               var_48.paletteMap(var_48,var_48.rect,DEFAULT_POINT,var_597.reds,[],[]);
            }
            else
            {
               var_48.copyChannel(var_48,var_48.rect,DEFAULT_POINT,2,8);
            }
         }
         if(_loc9_ != null && _loc13_)
         {
            cacheFullImage(_loc9_,var_48.clone());
         }
         if(param3 != 1)
         {
            var_48 = class_2495.resampleBitmapData(var_48,param3);
         }
         if(var_48 && param2)
         {
            return var_48.clone();
         }
         return var_48;
      }
      
      public function getHeadRegPoints(param1:String) : Point
      {
         var _loc2_:AvatarImageBodyPartContainer = _cache.getImageContainer("head",var_380);
         if(_loc2_ == null)
         {
            return new Point(0,0);
         }
         return new Point(_loc2_.regPoint.x,_loc2_.regPoint.y);
      }
      
      public function getFaceOffset(param1:String) : Point
      {
         var _loc2_:AvatarImageBodyPartContainer = _cache.getImageContainer("head",var_380);
         if(_loc2_ == null || _loc2_.faceOffset == null)
         {
            return new Point(0,0);
         }
         return new Point(_loc2_.faceOffset.x,_loc2_.faceOffset.y);
      }
      
      public function getCroppedImage(param1:String, param2:Number = 1) : BitmapData
      {
         var _loc11_:String = null;
         var _loc3_:AvatarImageBodyPartContainer = null;
         var _loc8_:BitmapData = null;
         var _loc7_:Point = null;
         var _loc9_:int = 0;
         if(var_183 == null)
         {
            return null;
         }
         if(!var_1114)
         {
            endActionAppends();
         }
         var _loc6_:AvatarCanvas = var_74.getCanvas(var_337,var_183.definition.geometryType);
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc4_:BitmapData = new BitmapData(_loc6_.width,_loc6_.height,true,16777215);
         var _loc5_:Array = var_74.getBodyParts(param1,var_183.definition.geometryType,var_658);
         var _loc10_:Rectangle = null;
         var _loc13_:Rectangle = new Rectangle();
         _loc9_ = _loc5_.length - 1;
         while(_loc9_ >= 0)
         {
            _loc11_ = _loc5_[_loc9_];
            _loc3_ = _cache.getImageContainer(_loc11_,var_380);
            if(_loc3_ != null)
            {
               _loc8_ = _loc3_.image;
               if(_loc8_ == null)
               {
                  _loc4_.dispose();
                  return null;
               }
               _loc7_ = _loc3_.regPoint;
               _loc4_.copyPixels(_loc8_,_loc8_.rect,_loc7_,null,null,true);
               _loc13_.x = _loc7_.x;
               _loc13_.y = _loc7_.y;
               _loc13_.width = _loc8_.width;
               _loc13_.height = _loc8_.height;
               if(_loc10_ == null)
               {
                  _loc10_ = _loc13_.clone();
               }
               else
               {
                  _loc10_ = _loc10_.union(_loc13_);
               }
            }
            _loc9_--;
         }
         if(_loc10_ == null)
         {
            _loc10_ = new Rectangle(0,0,1,1);
         }
         var _loc12_:BitmapData = new BitmapData(_loc10_.width,_loc10_.height,true,16777215);
         _loc12_.copyPixels(_loc4_,_loc10_,DEFAULT_POINT,null,null,true);
         _loc4_.dispose();
         if(param2 != 1)
         {
            _loc12_ = class_2495.resampleBitmapData(_loc12_,param2);
         }
         return _loc12_;
      }
      
      protected function getFullImage(param1:String) : BitmapData
      {
         return _fullImageCache[param1];
      }
      
      protected function cacheFullImage(param1:String, param2:BitmapData) : void
      {
         if(_fullImageCache.getValue(param1))
         {
            (_fullImageCache.getValue(param1) as BitmapData).dispose();
            _fullImageCache.remove(param1);
         }
         _fullImageCache[param1] = param2;
      }
      
      public function getAsset(param1:String) : BitmapDataAsset
      {
         return _assets.getAssetByName(param1) as BitmapDataAsset;
      }
      
      public function getDirection() : int
      {
         return var_658;
      }
      
      public function initActionAppends() : void
      {
         var_289 = [];
         var_1114 = false;
         var_494 = "";
         _useFullImageCache = false;
      }
      
      public function endActionAppends() : void
      {
         var _loc1_:* = null;
         if(sortActions())
         {
            for each(_loc1_ in var_446)
            {
               if(_loc1_.actionType == "fx")
               {
                  if(!var_3528.isReady(parseInt(_loc1_.actionParameter)))
                  {
                     var_3528.loadEffectData(parseInt(_loc1_.actionParameter),this);
                  }
               }
            }
            resetActions();
            setActionsToParts();
         }
      }
      
      public function appendAction(param1:String, ... rest) : Boolean
      {
         var_1114 = false;
         if(rest != null && rest.length > 0)
         {
            var _loc3_:String = rest[0];
         }
         loop0:
         switch(param1)
         {
            case "posture":
               switch(null)
               {
                  case "lay":
                     if(var_658 == 0)
                     {
                        setDirection("full",4);
                        break;
                     }
                     setDirection("full",2);
                     break;
                  case "mv":
                  case "std":
                  case "sit":
                     break;
                  case "swim":
                  case "float":
                  case "swrun":
                  case "swdiefront":
                  case "swdieback":
                  case "swpick":
                  case "swthrow":
                     _useFullImageCache = false;
                     addActionData(null);
                     break loop0;
                  default:
                     errorThis("appendAction() >> UNKNOWN POSTURE TYPE: " + null);
                     break loop0;
               }
               _useFullImageCache = true;
               addActionData(null);
               break;
            case "gest":
               switch(null)
               {
                  case "agr":
                  case "sad":
                  case "sml":
                  case "srp":
                     addActionData(null);
                     break;
                  default:
                     errorThis("appendAction() >> UNKNOWN GESTURE TYPE: " + null);
               }
               break;
            case "fx":
            case "dance":
            case "talk":
            case "wave":
            case "Sleep":
            case "sign":
            case "respect":
            case "blow":
            case "laugh":
            case "cry":
            case "idle":
            case "sbollie":
            case "sb360":
            case "ridejump":
               addActionData(param1,null);
               break;
            case "cri":
            case "usei":
               var _loc4_:ActionDefinition = var_74.getActionDefinitionWithState(param1);
               if(_loc4_ != null)
               {
                  logThis("appendAction:" + [null,"->",null.getParameterValue(null)]);
                  _loc3_ = null.getParameterValue(null);
               }
               addActionData(param1,null);
               break;
            default:
               errorThis("appendAction() >> UNKNOWN ACTION TYPE: " + param1);
         }
         return true;
      }
      
      protected function addActionData(param1:String, param2:String = "") : void
      {
         var _loc4_:ActiveActionData = null;
         var _loc3_:int = 0;
         if(var_289 == null)
         {
            var_289 = [];
         }
         _loc3_ = 0;
         while(_loc3_ < var_289.length)
         {
            _loc4_ = var_289[_loc3_];
            if(_loc4_.actionType == param1 && _loc4_.actionParameter == param2)
            {
               return;
            }
            _loc3_++;
         }
         var_289.push(new ActiveActionData(param1,param2,var_380));
      }
      
      public function isAnimating() : Boolean
      {
         return var_652 || var_4490 > 1;
      }
      
      private function resetActions() : Boolean
      {
         var_2180 = false;
         var_652 = false;
         var_170 = new Vector.<ISpriteDataContainer>(0);
         var_597 = null;
         _directionOffset = 0;
         var_74.removeDynamicItems(this);
         var_183 = _defaultAction;
         var_183.definition = _defaultAction.definition;
         resetBodyPartCache(_defaultAction);
         return true;
      }
      
      private function isHeadTurnPreventedByAction() : Boolean
      {
         var _loc2_:class_2768 = null;
         var _loc1_:* = null;
         if(var_446 == null)
         {
            return false;
         }
         for each(_loc1_ in var_446)
         {
            _loc2_ = var_74.getActionDefinitionWithState(_loc1_.actionType);
            if(!(_loc1_.actionType == "Sleep" && var_183 && var_183.actionType != "lay"))
            {
               if(_loc2_ != null && _loc2_.getPreventHeadTurn(_loc1_.actionParameter))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function sortActions() : Boolean
      {
         var_494 = "";
         var_446 = var_74.sortActions(var_289);
         var_4490 = var_74.maxFrames(var_446);
         if(var_446 == null)
         {
            var_721 = new Array(0,0,0);
            if(var_1064 != "")
            {
               var _loc3_:Boolean = true;
               var_1064 = "";
            }
         }
         else
         {
            var_721 = var_74.getCanvasOffsets(var_446,var_337,var_658);
            for each(var _loc4_ in var_446)
            {
               var_494 += null.actionType + null.actionParameter;
               if(null.actionType == "fx")
               {
                  var _loc2_:int = parseInt(null.actionParameter);
                  if(var_2188 != 0)
                  {
                     var _loc5_:Boolean = true;
                  }
                  var_2188 = 0;
                  var _loc1_:Boolean = true;
               }
            }
            if(var_2188 > -1)
            {
               _loc5_ = true;
            }
            var_2188 = -1;
            if(var_1064 != var_494)
            {
               _loc3_ = true;
               var_1064 = var_494;
            }
         }
         var_1114 = true;
         return false;
      }
      
      private function setActionsToParts() : void
      {
         var _loc2_:* = null;
         var _loc6_:Animation = null;
         var _loc1_:Array = null;
         var _loc4_:* = null;
         if(var_446 == null)
         {
            return;
         }
         var _loc3_:int = getTimer();
         var _loc7_:Array = [];
         for each(_loc2_ in var_446)
         {
            _loc7_.push(_loc2_.actionType);
         }
         for each(_loc2_ in var_446)
         {
            if(_loc2_ && _loc2_.definition && _loc2_.definition.isAnimation)
            {
               _loc6_ = var_74.getAnimation(_loc2_.definition.state + "." + _loc2_.actionParameter);
               if(_loc6_ && _loc6_.hasOverriddenActions())
               {
                  _loc1_ = _loc6_.overriddenActionNames();
                  if(_loc1_)
                  {
                     for each(_loc4_ in _loc1_)
                     {
                        if(_loc7_.indexOf(_loc4_) >= 0)
                        {
                           _loc2_.overridingAction = _loc6_.overridingAction(_loc4_);
                        }
                     }
                  }
               }
               if(_loc6_ && _loc6_.resetOnToggle)
               {
                  var_2180 = true;
               }
            }
         }
         for each(_loc2_ in var_446)
         {
            if(!(!_loc2_ || !_loc2_.definition))
            {
               if(_loc2_.definition.isAnimation && _loc2_.actionParameter == "")
               {
                  _loc2_.actionParameter = "1";
               }
               setActionToParts(_loc2_,_loc3_);
               if(_loc2_.definition.isAnimation)
               {
                  var_652 = _loc2_.definition.isAnimated(_loc2_.actionParameter);
                  _loc6_ = var_74.getAnimation(_loc2_.definition.state + "." + _loc2_.actionParameter);
                  if(_loc6_ != null)
                  {
                     var _loc5_:Vector.<ISpriteDataContainer> = _loc6_.spriteData;
                     if(_loc5_)
                     {
                        var_170 = var_170.concat(undefined);
                     }
                     if(_loc6_.hasDirectionData())
                     {
                        _directionOffset = _loc6_.directionData.offset;
                     }
                     if(_loc6_.hasAvatarData())
                     {
                        var_597 = _loc6_.avatarData;
                     }
                  }
               }
            }
         }
      }
      
      private function setActionToParts(param1:class_2501, param2:int) : void
      {
         if(param1 == null || param1.definition == null)
         {
            return;
         }
         if(param1.definition.assetPartDefinition == "")
         {
            return;
         }
         if(param1.definition.isMain)
         {
            var_183 = param1;
            _cache.setGeometryType(param1.definition.geometryType);
         }
         _cache.setAction(param1,param2);
         var_247 = true;
      }
      
      private function resetBodyPartCache(param1:class_2501) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.definition.assetPartDefinition == "")
         {
            return;
         }
         if(param1.definition.isMain)
         {
            var_183 = param1;
            _cache.setGeometryType(param1.definition.geometryType);
         }
         _cache.resetBodyPartCache(param1);
         var_247 = true;
      }
      
      public function get avatarSpriteData() : class_2792
      {
         return var_597;
      }
      
      private function convertToGrayscale(param1:BitmapData, param2:String = "CHANNELS_EQUAL") : BitmapData
      {
         var _loc5_:Number = 0.33;
         var _loc8_:Number = 0.33;
         var _loc6_:Number = 0.33;
         switch(param2)
         {
            case "CHANNELS_UNIQUE":
               _loc5_ = 0.3;
               _loc8_ = 0.59;
               _loc6_ = 0.11;
               break;
            case "CHANNELS_RED":
               _loc5_ = 1;
               _loc8_ = 0;
               _loc6_ = 0;
               break;
            case "CHANNELS_GREEN":
               _loc5_ = 0;
               _loc8_ = 1;
               _loc6_ = 0;
               break;
            case "CHANNELS_BLUE":
               _loc5_ = 0;
               _loc8_ = 0;
               _loc6_ = 1;
               break;
            case "CHANNELS_DESATURATED":
               _loc5_ = 0.3086;
               _loc8_ = 0.6094;
               _loc6_ = 0.082;
         }
         var _loc7_:Array = [_loc5_,_loc8_,_loc6_,0,0,_loc5_,_loc8_,_loc6_,0,0,_loc5_,_loc8_,_loc6_,0,0,0,0,0,1,0];
         var _loc3_:ColorMatrixFilter = new ColorMatrixFilter(_loc7_);
         var _loc9_:BitmapData = new BitmapData(param1.width,param1.height,param1.transparent,4294967295);
         _loc9_.copyPixels(param1,param1.rect,DEFAULT_POINT,null,null,false);
         _loc9_.applyFilter(_loc9_,_loc9_.rect,DEFAULT_POINT,_loc3_);
         return _loc9_;
      }
      
      private function errorThis(param1:String) : void
      {
      }
      
      private function logThis(param1:String) : void
      {
      }
      
      public function isPlaceholder() : Boolean
      {
         return false;
      }
      
      public function isBlocked() : Boolean
      {
         return false;
      }
      
      public function forceActionUpdate() : void
      {
         var_1064 = "";
      }
      
      public function get animationHasResetOnToggle() : Boolean
      {
         return var_2180;
      }
      
      public function get mainAction() : String
      {
         return var_183.actionType;
      }
      
      public function disposeInactiveActionCache() : void
      {
         if(_cache)
         {
            _cache.disposeInactiveActions();
         }
      }
      
      public function avatarEffectReady(param1:int) : void
      {
         if(param1 == var_2188)
         {
            resetActions();
            setActionsToParts();
            var_2180 = true;
            var_247 = true;
            if(var_3529)
            {
               var_3529.avatarEffectReady(param1);
            }
         }
      }
      
      public function resetCache() : void
      {
         if(_cache != null)
         {
            _cache.reset();
         }
         if(_fullImageCache)
         {
            for each(var _loc1_ in _fullImageCache)
            {
               _loc1_.dispose();
            }
            _fullImageCache.dispose();
            _fullImageCache = new class_55();
         }
         var_2017 = [];
         var_2802 = -1;
         var_3167 = null;
         var_3272 = null;
         var_1064 = "";
         var_1114 = false;
         var_247 = true;
         var_1100 = false;
         if(var_48)
         {
            var_48.dispose();
            var_48 = null;
         }
         var_380 = 0;
      }
   }
}

