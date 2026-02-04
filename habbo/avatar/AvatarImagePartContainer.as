package com.sulake.habbo.avatar
{
   import com.sulake.habbo.avatar.actions.class_2768;
   import com.sulake.habbo.avatar.structure.animation.AnimationFrame;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import flash.geom.ColorTransform;
   
   public class AvatarImagePartContainer
   {
      
      private var var_3502:String;
      
      private var var_3174:String;
      
      private var var_4027:String;
      
      private var var_2953:String;
      
      private var _color:IPartColor;
      
      private var var_353:Array;
      
      private var _action:class_2768;
      
      private var var_2093:Boolean;
      
      private var var_4751:Boolean;
      
      private var var_4446:ColorTransform;
      
      private var var_4253:int;
      
      public function AvatarImagePartContainer(param1:String, param2:String, param3:String, param4:IPartColor, param5:Array, param6:class_2768, param7:Boolean, param8:int, param9:String = "", param10:Boolean = false, param11:Number = 1)
      {
         super();
         var_3502 = param1;
         var_3174 = param2;
         var_2953 = param3;
         _color = param4;
         var_353 = param5;
         _action = param6;
         var_2093 = param7;
         var_4253 = param8;
         var_4027 = param9;
         var_4751 = param10;
         var_4446 = new ColorTransform(1,1,1,param11);
         if(var_353 == null)
         {
            class_21.log("Null frame list");
         }
         if(var_3174 == "ey")
         {
            var_2093 = false;
         }
      }
      
      public function getFrameIndex(param1:int) : int
      {
         if(!var_353 || var_353.length == 0)
         {
            return 0;
         }
         var _loc2_:int = param1 % var_353.length;
         if(var_353[_loc2_] is AnimationFrame)
         {
            var _loc3_:AnimationFrame = var_353[_loc2_];
            return null.number;
         }
         return _loc2_;
      }
      
      public function getFrameDefinition(param1:int) : AnimationFrame
      {
         var _loc2_:int = param1 % var_353.length;
         if(var_353 && var_353.length > _loc2_)
         {
            if(var_353[_loc2_] is AnimationFrame)
            {
               return var_353[_loc2_] as AnimationFrame;
            }
         }
         return null;
      }
      
      public function getCacheableKey(param1:int) : String
      {
         var _loc3_:AnimationFrame = null;
         var _loc2_:int = param1 % var_353.length;
         if(var_353 && var_353.length > _loc2_)
         {
            if(var_353[_loc2_] is AnimationFrame)
            {
               _loc3_ = var_353[_loc2_] as AnimationFrame;
               return partId + ":" + _loc3_.assetPartDefinition + ":" + _loc3_.number;
            }
         }
         return partId + ":" + _loc2_;
      }
      
      public function get bodyPartId() : String
      {
         return var_3502;
      }
      
      public function get partType() : String
      {
         return var_3174;
      }
      
      public function get partId() : String
      {
         return var_2953;
      }
      
      public function get color() : IPartColor
      {
         return _color;
      }
      
      public function get action() : class_2768
      {
         return _action;
      }
      
      public function set isColorable(param1:Boolean) : void
      {
         var_2093 = param1;
      }
      
      public function get isColorable() : Boolean
      {
         return var_2093;
      }
      
      public function get paletteMapId() : int
      {
         return var_4253;
      }
      
      public function get flippedPartType() : String
      {
         return var_4027;
      }
      
      public function get isBlendable() : Boolean
      {
         return var_4751;
      }
      
      public function get blendTransform() : ColorTransform
      {
         return var_4446;
      }
      
      public function toString() : String
      {
         return [var_3502,var_3174,var_2953].join(":");
      }
   }
}

