package com.sulake.habbo.room.object.visualization.avatar
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
   import com.sulake.habbo.avatar.animation.class_2314;
   import com.sulake.habbo.avatar.animation.class_2792;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_1828;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.avatar.enum.class_2814;
   import com.sulake.habbo.room.object.visualization.avatar.additions.FloatingIdleZ;
   import com.sulake.habbo.room.object.visualization.avatar.additions.GameClickTarget;
   import com.sulake.habbo.room.object.visualization.avatar.additions.GuideStatusBubble;
   import com.sulake.habbo.room.object.visualization.avatar.additions.MutedBubble;
   import com.sulake.habbo.room.object.visualization.avatar.additions.NumberBubble;
   import com.sulake.habbo.room.object.visualization.avatar.additions.TypingBubble;
   import com.sulake.habbo.room.object.visualization.avatar.additions.class_2504;
   import com.sulake.habbo.room.object.visualization.avatar.additions.class_3512;
   import com.sulake.room.data.RoomObjectSpriteData;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.enum.RoomObjectSpriteType;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   import flash.filters.BitmapFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class AvatarVisualization extends RoomObjectSpriteVisualization implements class_259, class_1828
   {
      
      private static const AVATAR_SPRITE_TAG:String = "avatar";
      
      private static const AVATAR_SPRITE_DEFAULT_DEPTH:Number = -0.01;
      
      private static const AVATAR_OWN_DEPTH_ADJUST:Number = 0.001;
      
      private static const AVATAR_SPRITE_LAYING_DEPTH:Number = -0.409;
      
      private static const BASE_Y_SCALE:int = 1000;
      
      private static const ANIMATION_FRAME_UPDATE_INTERVAL:int = 2;
      
      private static const SNOWBOARDING_EFFECT:int = 97;
      
      private static const FREEZE_EFFECT:int = 218;
      
      private static const MAX_AVATARS_WITH_EFFECT:int = 3;
      
      private static const SPRITE_INDEX_AVATAR:int = 0;
      
      private static const const_276:int = 1;
      
      private static const INITIAL_RESERVED_SPRITES:int = 2;
      
      private static const ADDITION_ID_IDLE_BUBBLE:int = 1;
      
      private static const ADDITION_ID_TYPING_BUBBLE:int = 2;
      
      private static const ADDITION_ID_EXPRESSION:int = 3;
      
      private static const ADDITION_ID_NUMBER_BUBBLE:int = 4;
      
      private static const ADDITION_ID_GAME_CLICK_TARGET:int = 5;
      
      private static const ADDITION_ID_MUTED_BUBBLE:int = 6;
      
      private static const ADDITION_ID_GUIDE_STATUS_BUBBLE:int = 7;
      
      private static const DEFAULT_CANVAS_OFFSETS:Array = [0,0,0];
      
      private static const VARIABLE_HOLDER_FILTER:Array = [new ColorMatrixFilter([0.9,0,0,0,0,0,1,0,0,40,0,0,1,0,80,0,0,0,0.85,0]),new GlowFilter(12318714,1,4,4,4,1,true,false)];
      
      private var _lastAnimationUpdateTime:int = -1000;
      
      private const const_1241:int = 41;
      
      private var var_1618:AvatarVisualizationData = null;
      
      private var _avatars:class_55;
      
      private var var_1094:class_55;
      
      private var _updatesUntilFrameUpdate:int = 0;
      
      private var var_652:Boolean;
      
      private var var_975:String;
      
      private var var_111:String;
      
      private var var_2570:int = 0;
      
      private var _shadowAsset:BitmapDataAsset;
      
      private var _forceUpdate:Boolean;
      
      private var var_2194:int;
      
      private var _headAngle:int = -1;
      
      private var var_3083:int = -1;
      
      private var var_3568:int = -1;
      
      private var var_3760:int = 2;
      
      private var var_275:class_55;
      
      private var var_2795:int = -1;
      
      private var var_359:String = "";
      
      private var var_2908:String = "";
      
      private var var_3564:Boolean = false;
      
      private var var_2869:Boolean = false;
      
      private var var_2516:Boolean = false;
      
      private var var_3120:int = 0;
      
      private var var_2937:int = 0;
      
      private var var_2890:int = 0;
      
      private var var_3101:int = 0;
      
      private var var_3536:Boolean = false;
      
      private var var_3151:Boolean = false;
      
      private var var_2992:int = -1;
      
      private var var_996:Boolean = false;
      
      private var var_1137:int = 0;
      
      private var var_1734:int = 0;
      
      private var var_979:int = 0;
      
      private var _geometryOffset:int = 0;
      
      private var var_3100:int = 0;
      
      private var var_1248:Boolean = false;
      
      private var var_1643:Boolean = false;
      
      private var var_3364:Boolean = false;
      
      private var var_67:class_1827 = null;
      
      private var var_3752:Boolean = false;
      
      private var var_1134:Boolean;
      
      public function AvatarVisualization()
      {
         super();
         _avatars = new class_55();
         var_1094 = new class_55();
         var_652 = false;
         var_2194 = Math.random() * 200 + 200;
      }
      
      override public function dispose() : void
      {
         if(_avatars != null)
         {
            resetImages();
            _avatars.dispose();
            var_1094.dispose();
            _avatars = null;
         }
         var_1618 = null;
         _shadowAsset = null;
         if(var_275)
         {
            for each(var _loc1_ in var_275)
            {
               _loc1_.dispose();
            }
            var_275 = null;
         }
         super.dispose();
         var_1134 = true;
      }
      
      override public function getSpriteList() : Array
      {
         var _loc17_:RoomObjectSpriteData = null;
         var _loc6_:RoomObjectSpriteData = null;
         var _loc11_:class_2314 = null;
         var _loc18_:int = 0;
         var _loc1_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc19_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:String = null;
         var _loc2_:BitmapDataAsset = null;
         var _loc12_:Rectangle = null;
         var _loc5_:String = null;
         if(var_67 == null)
         {
            return null;
         }
         var _loc3_:IRoomObjectSprite = getSprite(1);
         if(_loc3_)
         {
            _loc17_ = new RoomObjectSpriteData();
            _loc17_.alpha = _loc3_.alpha;
            _loc17_.x = _loc3_.offsetX;
            _loc17_.y = _loc3_.offsetY;
            _loc17_.name = _loc3_.assetName;
            _loc17_.width = _loc3_.width;
            _loc17_.height = _loc3_.height;
         }
         var _loc9_:Array = var_67.getServerRenderData();
         for each(var _loc10_ in var_67.getSprites())
         {
            _loc6_ = new RoomObjectSpriteData();
            _loc11_ = var_67.getLayerData(_loc10_);
            _loc18_ = 0;
            _loc1_ = var_67.getDirection();
            _loc13_ = _loc10_.getDirectionOffsetX(_loc1_);
            _loc14_ = _loc10_.getDirectionOffsetY(_loc1_);
            _loc15_ = _loc10_.getDirectionOffsetZ(_loc1_);
            _loc19_ = 0;
            if(_loc10_.hasDirections)
            {
               _loc19_ = _loc1_;
            }
            if(_loc11_ != null)
            {
               _loc18_ = _loc11_.animationFrame;
               _loc13_ += _loc11_.dx;
               _loc14_ += _loc11_.dy;
               _loc19_ += _loc11_.directionOffset;
            }
            _loc8_ = 64;
            if(_loc8_ < 48)
            {
               _loc13_ /= 2;
               _loc14_ /= 2;
            }
            if(_loc19_ < 0)
            {
               _loc19_ += 8;
            }
            else if(_loc19_ > 7)
            {
               _loc19_ -= 8;
            }
            _loc7_ = var_67.getScale() + "_" + _loc10_.member + "_" + _loc19_ + "_" + _loc18_;
            _loc2_ = var_67.getAsset(_loc7_);
            if(_loc2_ != null)
            {
               _loc6_.x = -_loc2_.offset.x - _loc8_ / 2 + _loc13_;
               _loc6_.y = -_loc2_.offset.y + _loc14_;
               if(_loc10_.hasStaticY)
               {
                  _loc6_.y += var_3100 * _loc8_ / (2 * 1000);
               }
               if(_loc10_.ink == 33)
               {
                  _loc6_.blendMode = "add";
               }
               _loc6_.name = _loc7_;
               if(var_1643)
               {
                  _loc6_.z = -0.409 - 0.001 * spriteCount * _loc15_;
               }
               else
               {
                  _loc6_.z = -0.001 * spriteCount * _loc15_;
               }
               _loc12_ = _loc2_.rectangle;
               if(_loc12_ == null)
               {
                  _loc6_.width = 60;
                  _loc6_.height = 60;
               }
               else
               {
                  _loc6_.width = _loc12_.width;
                  _loc6_.height = _loc12_.height;
               }
               _loc9_.push(_loc6_);
            }
         }
         var _loc4_:class_2792 = var_67.avatarSpriteData;
         if(_loc4_ != null && _loc4_.paletteIsGrayscale)
         {
            _loc5_ = _loc4_.reds[0].toString();
            for each(var _loc16_ in _loc9_)
            {
               if(_loc16_.name.indexOf("h_std_fx") == -1 && _loc16_.name.indexOf("h_std_sd") == -1)
               {
                  _loc16_.color = _loc5_;
               }
            }
         }
         if(_loc17_)
         {
            _loc9_.push(_loc17_);
         }
         return _loc9_;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get angle() : int
      {
         return var_3083;
      }
      
      public function get posture() : String
      {
         return var_359;
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         var_1618 = param1 as AvatarVisualizationData;
         createSprites(2);
         return true;
      }
      
      private function updateModel(param1:IRoomObjectModel, param2:Number, param3:Boolean) : Boolean
      {
         var _loc7_:Boolean = false;
         var _loc4_:* = false;
         var _loc8_:int = 0;
         var _loc6_:String = null;
         var _loc9_:class_2504 = null;
         var _loc5_:String = null;
         if(param1.getUpdateID() != var_262)
         {
            _loc7_ = false;
            _loc4_ = false;
            _loc8_ = 0;
            _loc6_ = "";
            _loc4_ = param1.getNumber("figure_talk") > 0 && param3;
            if(_loc4_ != var_3564)
            {
               var_3564 = _loc4_;
               _loc7_ = true;
            }
            _loc8_ = param1.getNumber("figure_expression");
            if(_loc8_ != var_3120)
            {
               var_3120 = _loc8_;
               _loc7_ = true;
            }
            _loc4_ = param1.getNumber("figure_sleep") > 0;
            if(_loc4_ != var_2869)
            {
               var_2869 = _loc4_;
               _loc7_ = true;
            }
            _loc4_ = param1.getNumber("figure_blink") > 0 && param3;
            if(_loc4_ != var_2516)
            {
               var_2516 = _loc4_;
               _loc7_ = true;
            }
            _loc8_ = param1.getNumber("figure_gesture");
            if(_loc8_ != var_2937)
            {
               var_2937 = _loc8_;
               _loc7_ = true;
            }
            _loc6_ = param1.getString("figure_posture");
            if(_loc6_ != var_359)
            {
               var_359 = _loc6_;
               _loc7_ = true;
            }
            _loc6_ = param1.getString("figure_posture_parameter");
            if(_loc6_ != var_2908)
            {
               var_2908 = _loc6_;
               _loc7_ = true;
            }
            _loc4_ = param1.getNumber("figure_can_stand_up") > 0;
            if(_loc4_ != var_1248)
            {
               var_1248 = _loc4_;
               _loc7_ = true;
            }
            _loc8_ = param1.getNumber("figure_vertical_offset") * 1000;
            if(_loc8_ != var_3100)
            {
               var_3100 = _loc8_;
               _loc7_ = true;
            }
            _loc8_ = param1.getNumber("figure_dance");
            if(_loc8_ != var_2890)
            {
               var_2890 = _loc8_;
               _loc7_ = true;
            }
            _loc8_ = param1.getNumber("figure_effect");
            if(_loc8_ != var_1137)
            {
               var_1137 = _loc8_;
               _loc7_ = true;
            }
            _loc8_ = param1.getNumber("figure_carry_object");
            if(_loc8_ != var_1734)
            {
               var_1734 = _loc8_;
               _loc7_ = true;
            }
            _loc8_ = param1.getNumber("figure_use_object");
            if(_loc8_ != var_979)
            {
               var_979 = _loc8_;
               _loc7_ = true;
            }
            _loc8_ = param1.getNumber("head_direction");
            if(_loc8_ != _headAngle)
            {
               _headAngle = _loc8_;
               _loc7_ = true;
            }
            if(var_1734 > 0 && param1.getNumber("figure_use_object") > 0)
            {
               if(var_979 != var_1734)
               {
                  var_979 = var_1734;
                  _loc7_ = true;
               }
            }
            else if(var_979 != 0)
            {
               var_979 = 0;
               _loc7_ = true;
            }
            _loc9_ = getAddition(1) as FloatingIdleZ;
            if(var_2869)
            {
               if(!_loc9_)
               {
                  _loc9_ = addAddition(new FloatingIdleZ(1,this));
               }
               _loc7_ = true;
            }
            else if(_loc9_)
            {
               removeAddition(1);
            }
            _loc4_ = param1.getNumber("figure_is_muted") > 0;
            _loc9_ = getAddition(6) as MutedBubble;
            if(_loc4_)
            {
               if(!_loc9_)
               {
                  _loc9_ = addAddition(new MutedBubble(6,this));
               }
               removeAddition(2);
               _loc7_ = true;
            }
            else
            {
               if(_loc9_)
               {
                  removeAddition(6);
                  _loc7_ = true;
               }
               _loc4_ = param1.getNumber("figure_is_typing") > 0;
               _loc9_ = getAddition(2) as TypingBubble;
               if(_loc4_)
               {
                  if(!_loc9_)
                  {
                     _loc9_ = addAddition(new TypingBubble(2,this));
                  }
                  _loc7_ = true;
               }
               else if(_loc9_)
               {
                  removeAddition(2);
               }
            }
            _loc8_ = param1.getNumber("figure_guide_status");
            if(_loc8_ != 0)
            {
               removeAddition(7);
               addAddition(new GuideStatusBubble(7,this,_loc8_));
               _loc7_ = true;
            }
            else if(getAddition(7) as GuideStatusBubble != null)
            {
               removeAddition(7);
               _loc7_ = true;
            }
            _loc4_ = param1.getNumber("figure_is_playing_game") > 0;
            _loc9_ = getAddition(5) as GameClickTarget;
            if(_loc4_)
            {
               if(!_loc9_)
               {
                  _loc9_ = addAddition(new GameClickTarget(5));
               }
               _loc7_ = true;
            }
            else if(_loc9_)
            {
               removeAddition(5);
            }
            _loc8_ = param1.getNumber("figure_number_value");
            _loc9_ = getAddition(4) as NumberBubble;
            if(_loc8_ > 0)
            {
               if(!_loc9_)
               {
                  _loc9_ = addAddition(new NumberBubble(4,_loc8_,this));
               }
               _loc7_ = true;
            }
            else if(_loc9_)
            {
               removeAddition(4);
            }
            _loc8_ = param1.getNumber("figure_expression");
            _loc9_ = getAddition(3);
            if(_loc8_ > 0)
            {
               if(!_loc9_)
               {
                  _loc9_ = class_3512.make(3,_loc8_,this);
                  if(_loc9_)
                  {
                     addAddition(_loc9_);
                  }
               }
            }
            else if(_loc9_)
            {
               removeAddition(3);
            }
            validateActions(param2);
            _loc6_ = param1.getString("gender");
            if(_loc6_ != var_111)
            {
               var_111 = _loc6_;
               _loc7_ = true;
            }
            _loc5_ = param1.getString("figure");
            if(updateFigure(_loc5_))
            {
               _loc7_ = true;
            }
            if(param1.hasNumber("figure_sign"))
            {
               _loc8_ = param1.getNumber("figure_sign");
               if(_loc8_ != var_2992)
               {
                  _loc7_ = true;
                  var_2992 = _loc8_;
               }
            }
            if(param1.hasNumber("blocked"))
            {
               _loc4_ = param1.getNumber("blocked") > 0;
               if(updateBlocked(_loc4_))
               {
                  _loc7_ = true;
               }
            }
            _loc4_ = param1.getNumber("figure_highlight_enable") > 0;
            if(_loc4_ != var_3536)
            {
               var_3536 = _loc4_;
               _loc7_ = true;
            }
            if(var_3536)
            {
               _loc8_ = param1.getNumber("figure_highlight");
               if(_loc8_ != var_3101)
               {
                  var_3101 = _loc8_;
                  _loc7_ = true;
               }
            }
            _loc4_ = param1.getNumber("figure_highlight_variable_holder") > 0;
            if(_loc4_ != var_3151)
            {
               var_3151 = _loc4_;
               _loc7_ = true;
            }
            _loc4_ = param1.getNumber("own_user") > 0;
            if(_loc4_ != var_3752)
            {
               var_3752 = _loc4_;
               _loc7_ = true;
            }
            var_262 = param1.getUpdateID();
            return _loc7_;
         }
         return false;
      }
      
      private function updateFigure(param1:String) : Boolean
      {
         if(var_975 != param1)
         {
            var_975 = param1;
            resetImages();
            return true;
         }
         return false;
      }
      
      private function updateBlocked(param1:Boolean) : Boolean
      {
         if(var_996 != param1)
         {
            var_996 = param1;
            resetImages();
            return true;
         }
         return false;
      }
      
      private function resetImages() : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in _avatars)
         {
            if(_loc2_)
            {
               _loc2_.dispose();
            }
         }
         for each(_loc2_ in var_1094)
         {
            if(_loc2_)
            {
               _loc2_.dispose();
            }
         }
         _avatars.reset();
         var_1094.reset();
         var_67 = null;
         var _loc1_:IRoomObjectSprite = getSprite(0);
         if(_loc1_ != null)
         {
            _loc1_.asset = null;
            _loc1_.alpha = 255;
         }
      }
      
      private function validateActions(param1:Number) : void
      {
         if(param1 < 48)
         {
            var_2516 = false;
         }
         if(var_359 == "sit" || var_359 == "lay")
         {
            _geometryOffset = param1 / 2;
         }
         else
         {
            _geometryOffset = 0;
         }
         var_3364 = false;
         var_1643 = false;
         if(var_359 == "lay")
         {
            var_1643 = true;
            var _loc2_:int = int(var_2908);
         }
      }
      
      private function getAvatarImage(param1:Number, param2:int) : class_1827
      {
         var _loc4_:class_1827 = null;
         var _loc5_:class_1827 = null;
         var _loc3_:String = "avatarImage" + param1.toString();
         if(param2 == 0)
         {
            _loc4_ = _avatars.getValue(_loc3_) as class_1827;
         }
         else
         {
            _loc3_ += "-" + param2;
            _loc4_ = var_1094.getValue(_loc3_) as class_1827;
            if(_loc4_)
            {
               _loc4_.forceActionUpdate();
            }
         }
         if(_loc4_ == null)
         {
            _loc4_ = var_1618.getAvatar(var_975,param1,var_111,this,this,var_996);
            if(_loc4_ != null)
            {
               if(param2 == 0)
               {
                  _avatars.add(_loc3_,_loc4_);
               }
               else
               {
                  if(var_1094.length >= 3)
                  {
                     _loc5_ = var_1094.remove(var_1094.getKey(0));
                     if(_loc5_)
                     {
                        _loc5_.dispose();
                     }
                  }
                  var_1094.add(_loc3_,_loc4_);
               }
            }
         }
         return _loc4_;
      }
      
      public function getAvatarRendererAsset(param1:String) : IAsset
      {
         return var_1618 ? var_1618.getAvatarRendererAsset(param1) : null;
      }
      
      private function updateObject(param1:IRoomObject, param2:IRoomGeometry, param3:Boolean, param4:Boolean = false) : Boolean
      {
         var _loc6_:Boolean = false;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         if(param4 || var_1559 != param1.getUpdateID() || var_2795 != param2.updateId)
         {
            _loc6_ = param3;
            _loc5_ = param1.getDirection().x - param2.direction.x;
            _loc5_ = (_loc5_ % 360 + 360) % 360;
            if(var_359 == "sit" && var_1248)
            {
               _loc5_ -= _loc5_ % 90 - 45;
            }
            _loc7_ = _headAngle;
            if(var_359 == "float")
            {
               _loc7_ = _loc5_;
            }
            else
            {
               _loc7_ -= param2.direction.x;
            }
            _loc7_ = (_loc7_ % 360 + 360) % 360;
            if(var_359 == "sit" && var_1248 || var_359 == "swdieback" || var_359 == "swdiefront")
            {
               _loc7_ -= _loc7_ % 90 - 45;
            }
            if(_loc5_ != var_3083 || param4)
            {
               _loc6_ = true;
               var_3083 = _loc5_;
               _loc5_ -= 112.5;
               _loc5_ = (_loc5_ + 360) % 360;
               var_67.setDirectionAngle("full",_loc5_);
            }
            if(_loc7_ != var_3568 || param4)
            {
               _loc6_ = true;
               var_3568 = _loc7_;
               if(var_3568 != var_3083)
               {
                  _loc7_ -= 112.5;
                  _loc7_ = (_loc7_ + 360) % 360;
                  var_67.setDirectionAngle("head",_loc7_);
               }
            }
            var_1559 = param1.getUpdateID();
            var_2795 = param2.updateId;
            return _loc6_;
         }
         return false;
      }
      
      private function updateShadow(param1:Number) : void
      {
         var _loc5_:IRoomObjectSprite = getSprite(1);
         _shadowAsset = null;
         var _loc4_:Boolean = var_359 == "mv" || var_359 == "std" || var_359 == "sit" && var_1248;
         if(var_1137 == 97 || var_1137 == 218)
         {
            _loc4_ = false;
         }
         if(_loc4_)
         {
            _loc5_.visible = true;
            if(_shadowAsset == null || param1 != var_199)
            {
               var _loc2_:int = 0;
               var _loc3_:int = 0;
               if(param1 < 48)
               {
                  _loc5_.libraryAssetName = "sh_std_sd_1_0_0";
                  _shadowAsset = var_67.getAsset(_loc5_.libraryAssetName);
                  _loc2_ = -8;
                  _loc3_ = var_1248 ? 6 : -3;
               }
               else
               {
                  _loc5_.libraryAssetName = "h_std_sd_1_0_0";
                  _shadowAsset = var_67.getAsset(_loc5_.libraryAssetName);
                  _loc2_ = -17;
                  _loc3_ = var_1248 ? 10 : -7;
               }
               if(_shadowAsset != null)
               {
                  _loc5_.asset = _shadowAsset.content as BitmapData;
                  _loc5_.offsetX = 0;
                  _loc5_.offsetY = 0;
                  _loc5_.alpha = 50;
                  _loc5_.relativeDepth = 1;
               }
               else
               {
                  _loc5_.visible = false;
               }
            }
         }
         else
         {
            _shadowAsset = null;
            _loc5_.visible = false;
         }
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc38_:IRoomObject = object;
         if(_loc38_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(var_1618 == null)
         {
            return;
         }
         if(--var_2194 <= 0 && var_67)
         {
            var_67.disposeInactiveActionCache();
            var_2194 = 500;
         }
         var _loc15_:* = param2 >= _lastAnimationUpdateTime + 41;
         if(_loc15_)
         {
            _lastAnimationUpdateTime += 41;
            if(_lastAnimationUpdateTime + 41 < param2)
            {
               _lastAnimationUpdateTime = param2 - 41;
            }
         }
         var _loc23_:IRoomObjectModel = _loc38_.getModel();
         var _loc11_:Number = param1.scale;
         var _loc20_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc34_:int = var_1137;
         var _loc40_:Boolean = false;
         var _loc32_:Boolean = updateModel(_loc23_,_loc11_,param3);
         if(_forceUpdate)
         {
            resetImages();
            _forceUpdate = false;
         }
         if(_loc32_ || _loc11_ != var_199 || var_67 == null)
         {
            if(_loc11_ != var_199)
            {
               _loc20_ = true;
               validateActions(_loc11_);
            }
            if(_loc34_ != var_1137)
            {
               _loc40_ = true;
            }
            if(_loc20_ || var_67 == null || _loc40_)
            {
               var_67 = getAvatarImage(_loc11_,var_1137);
               if(var_67 == null)
               {
                  return;
               }
               var _loc7_:Boolean = true;
               var _loc10_:IRoomObjectSprite = getSprite(0);
               if(_loc10_)
               {
                  if(var_67 && (var_67.isPlaceholder() || var_67.isBlocked()))
                  {
                     null.alpha = 150;
                     if(var_67.isBlocked())
                     {
                        null.color = 6710886;
                     }
                     else
                     {
                        null.color = 16777215;
                     }
                  }
                  else
                  {
                     null.alpha = 255;
                     null.color = 16777215;
                  }
               }
            }
            if(var_67 == null)
            {
               return;
            }
            if(_loc40_ && var_67.animationHasResetOnToggle)
            {
               var_67.resetAnimationFrameCounter();
            }
            updateShadow(_loc11_);
            _loc9_ = updateObject(_loc38_,param1,param3,true);
            updateActions(var_67);
            if(var_275)
            {
               _loc5_ = var_3760;
               for each(var _loc24_ in var_275)
               {
                  _loc24_.update(getSprite(_loc5_++),_loc11_);
               }
            }
            var_199 = _loc11_;
         }
         else
         {
            _loc9_ = updateObject(_loc38_,param1,param3);
         }
         if(_loc15_ && var_275)
         {
            _loc5_ = var_3760;
            for each(_loc24_ in var_275)
            {
               if(_loc24_.animate(getSprite(_loc5_++)))
               {
                  increaseUpdateId();
               }
            }
         }
         var _loc39_:Boolean = _loc9_ || _loc32_ || _loc20_;
         var _loc29_:Boolean = (var_652 || var_2570 > 0) && param3 && _loc15_;
         if(_loc39_)
         {
            var_2570 = 2;
         }
         if(_loc39_ || _loc29_)
         {
            increaseUpdateId();
            if(_loc15_)
            {
               var_2570 = var_2570 - 1;
               _updatesUntilFrameUpdate = _updatesUntilFrameUpdate - 1;
            }
            if(!(_updatesUntilFrameUpdate <= 0 || _loc20_ || _loc32_))
            {
               return;
            }
            var_67.updateAnimationByFrames(1);
            _updatesUntilFrameUpdate = 2;
            var _loc18_:Array = var_67.getCanvasOffsets();
            if(_loc18_ == null || null.length < 3)
            {
               _loc18_ = DEFAULT_CANVAS_OFFSETS;
            }
            var _loc22_:IRoomObjectSprite = getSprite(0);
            if(_loc22_ != null)
            {
               var _loc26_:BitmapData = var_67.getImage("full",var_3101 || var_3151);
               if(_loc26_ != null)
               {
                  if(var_3101)
                  {
                     var _loc35_:BitmapFilter = new GlowFilter(16777215,1,6,6);
                     null.applyFilter(null,null.rect,new Point(0,0),null);
                  }
                  else if(var_3151)
                  {
                     for each(_loc35_ in VARIABLE_HOLDER_FILTER)
                     {
                        null.applyFilter(null,null.rect,new Point(0,0),null);
                     }
                  }
                  null.asset = null;
               }
               if(null.asset)
               {
                  null.offsetX = -1 * _loc11_ / 2 + null[0] - (null.asset.width - _loc11_) / 2;
                  null.offsetY = -null.asset.height + _loc11_ / 4 + null[1] + _geometryOffset;
                  if(var_359 == "swdieback" || var_359 == "swdiefront")
                  {
                     null.offsetY += 20 * _loc11_ / 32;
                  }
               }
               if(var_1643)
               {
                  if(var_3364)
                  {
                     null.relativeDepth = -0.5;
                  }
                  else
                  {
                     null.relativeDepth = -0.409 + null[2];
                  }
               }
               else
               {
                  null.relativeDepth = -0.01 + null[2];
               }
               if(var_3752)
               {
                  null.relativeDepth -= 0.001;
                  null.spriteType = RoomObjectSpriteType.var_4695;
               }
               else
               {
                  null.spriteType = RoomObjectSpriteType.AVATAR;
               }
            }
            _loc24_ = getAddition(2) as TypingBubble;
            if(_loc24_)
            {
               if(!var_1643)
               {
                  TypingBubble(_loc24_).relativeDepth = -0.01 - 0.01 + null[2];
               }
               else
               {
                  TypingBubble(_loc24_).relativeDepth = -0.409 - 0.01 + null[2];
               }
            }
            var_652 = var_67.isAnimating();
            var _loc33_:int = 2;
            var _loc27_:int = var_67.getDirection();
            for each(var _loc14_ in var_67.getSprites())
            {
               if(_loc14_.id == "avatar")
               {
                  _loc22_ = getSprite(0);
                  var _loc28_:class_2314 = var_67.getLayerData(_loc14_);
                  var _loc13_:int = _loc14_.getDirectionOffsetX(0);
                  var _loc12_:int = _loc14_.getDirectionOffsetY(0);
                  if(_loc11_ < 48)
                  {
                     _loc13_ = 0 / 2;
                     _loc12_ = 0 / 2;
                  }
                  if(!var_1248)
                  {
                     null.offsetX += 0;
                     null.offsetY += 0;
                  }
               }
               else
               {
                  _loc22_ = getSprite(0);
                  if(_loc22_ != null)
                  {
                     null.alphaTolerance = 256;
                     null.visible = true;
                     var _loc16_:class_2314 = var_67.getLayerData(_loc14_);
                     var _loc41_:int = 0;
                     var _loc17_:int = _loc14_.getDirectionOffsetX(0);
                     var _loc19_:int = _loc14_.getDirectionOffsetY(0);
                     var _loc21_:int = _loc14_.getDirectionOffsetZ(0);
                     var _loc25_:int = 0;
                     if(_loc14_.hasDirections)
                     {
                        _loc25_ = 0;
                     }
                     if(_loc11_ < 48)
                     {
                        _loc17_ = 0 / 2;
                        _loc19_ = 0 / 2;
                     }
                     var _loc30_:String = var_67.getScale() + "_" + _loc14_.member + "_" + 0 + "_" + 0;
                     var _loc6_:BitmapDataAsset = var_67.getAsset(null);
                     var _loc31_:int = var_67.getScale() == "sh" ? 32 : 64;
                     var _loc8_:Boolean = false;
                     if(var_67.getScale() == "sh")
                     {
                        _loc30_ = "h_" + _loc14_.member + "_" + 0 + "_" + 0;
                        _loc6_ = var_67.getAsset(null);
                        _loc8_ = true;
                     }
                  }
                  else
                  {
                     _loc33_++;
                  }
               }
            }
         }
      }
      
      private function updateActions(param1:class_1827) : void
      {
         var _loc3_:String = null;
         if(param1 == null)
         {
            return;
         }
         param1.initActionAppends();
         param1.appendAction("posture",var_359,var_2908);
         if(var_2937 > 0)
         {
            param1.appendAction("gest",class_2814.getGesture(var_2937));
         }
         if(var_2890 > 0)
         {
            param1.appendAction("dance",var_2890);
         }
         if(var_2992 > -1)
         {
            param1.appendAction("sign",var_2992);
         }
         if(var_1734 > 0)
         {
            param1.appendAction("cri",var_1734);
         }
         if(var_979 > 0)
         {
            param1.appendAction("usei",var_979);
         }
         if(var_3564)
         {
            param1.appendAction("talk");
         }
         if(var_2869 || var_2516)
         {
            param1.appendAction("Sleep");
         }
         if(var_3120 > 0)
         {
            _loc3_ = class_2814.getExpression(var_3120);
            if(_loc3_ != "")
            {
               var _loc7_:String = _loc3_;
               if("dance" !== _loc7_)
               {
                  param1.appendAction(_loc3_);
               }
               else
               {
                  param1.appendAction("dance",2);
               }
            }
         }
         if(var_1137 > 0)
         {
            param1.appendAction("fx",var_1137);
         }
         param1.endActionAppends();
         var_652 = param1.isAnimating();
         var _loc2_:int = 2;
         for each(var _loc4_ in var_67.getSprites())
         {
            if(_loc4_.id != "avatar")
            {
               _loc2_++;
            }
         }
         if(_loc2_ != spriteCount)
         {
            createSprites(_loc2_);
         }
         var_3760 = _loc2_;
         if(var_275)
         {
            for each(var _loc6_ in var_275)
            {
               var _loc5_:IRoomObjectSprite = addSprite();
            }
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         _forceUpdate = true;
      }
      
      public function avatarEffectReady(param1:int) : void
      {
         _forceUpdate = true;
      }
      
      protected function get numAdditions() : int
      {
         return var_275 ? var_275.length : 0;
      }
      
      public function addAddition(param1:class_2504) : class_2504
      {
         if(!var_275)
         {
            var_275 = new class_55();
         }
         if(var_275.hasKey(param1.id))
         {
            throw new Error("Avatar addition with index " + param1.id + "already exists!");
         }
         var_275.add(param1.id,param1);
         return param1;
      }
      
      public function getAddition(param1:int) : class_2504
      {
         return var_275 ? var_275[param1] : null;
      }
      
      public function removeAddition(param1:int) : void
      {
         var _loc2_:class_2504 = getAddition(param1);
         if(!_loc2_)
         {
            return;
         }
         var_275.remove(param1);
         _loc2_.dispose();
      }
   }
}

