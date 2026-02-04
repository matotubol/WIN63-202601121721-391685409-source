package com.sulake.habbo.avatar.geometry
{
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.structure.AvatarCanvas;
   import flash.utils.Dictionary;
   
   public class AvatarModelGeometry
   {
      
      private var var_3769:AvatarSet;
      
      private var var_1660:Dictionary;
      
      private var var_3718:Dictionary;
      
      private var var_1590:Matrix4x4;
      
      private var _camera:Vector3D;
      
      private var var_291:Dictionary;
      
      public function AvatarModelGeometry(param1:XML)
      {
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         _camera = new Vector3D(0,0,10);
         super();
         var_1590 = new Matrix4x4();
         var_1660 = new Dictionary();
         var_3718 = new Dictionary();
         var_3769 = new AvatarSet(param1.avatarset[0]);
         var_291 = new Dictionary();
         var _loc8_:XML = param1.camera[0];
         if(_loc8_ != null)
         {
            _loc12_ = parseFloat(_loc8_.x.text());
            _loc13_ = parseFloat(_loc8_.y.text());
            _loc14_ = parseFloat(_loc8_.z.text());
            _camera.x = _loc12_;
            _camera.y = _loc13_;
            _camera.z = _loc14_;
         }
         for each(var _loc2_ in param1.canvas)
         {
            var _loc6_:String = String(null.@scale);
            var _loc4_:Dictionary = new Dictionary();
            for each(var _loc10_ in null.geometry)
            {
               var _loc11_:AvatarCanvas = new AvatarCanvas(null,null);
               null[String(null.@id)] = null;
            }
            var_291[null] = null;
         }
         for each(var _loc15_ in param1.type)
         {
            var _loc7_:Dictionary = new Dictionary();
            var _loc5_:Dictionary = new Dictionary();
            for each(var _loc3_ in null.bodypart)
            {
               var _loc9_:GeometryBodyPart = new GeometryBodyPart(null);
               null[String(null.@id)] = null;
               for each(var _loc16_ in null.getPartIds(null))
               {
                  null[_loc16_] = null;
               }
            }
            var_1660[String(null.@id)] = null;
            var_3718[String(null.@id)] = null;
         }
      }
      
      public function removeDynamicItems(param1:class_1827) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         for each(_loc2_ in var_1660)
         {
            for each(_loc3_ in _loc2_)
            {
               _loc3_.removeDynamicParts(param1);
            }
         }
      }
      
      public function getBodyPartIdsInAvatarSet(param1:String) : Array
      {
         var _loc3_:Array = [];
         var _loc2_:AvatarSet = var_3769.findAvatarSet(param1);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getBodyParts();
         }
         return _loc3_;
      }
      
      public function isMainAvatarSet(param1:String) : Boolean
      {
         var _loc2_:AvatarSet = var_3769.findAvatarSet(param1);
         if(_loc2_ != null)
         {
            return _loc2_.isMain;
         }
         return false;
      }
      
      public function getCanvas(param1:String, param2:String) : AvatarCanvas
      {
         var _loc3_:Dictionary = var_291[param1];
         if(_loc3_ != null)
         {
            var _loc4_:AvatarCanvas = _loc3_[param2] as AvatarCanvas;
         }
         return null;
      }
      
      private function typeExists(param1:String) : Boolean
      {
         return var_1660[param1] != null;
      }
      
      private function hasBodyPart(param1:String, param2:String) : Boolean
      {
         if(typeExists(param1))
         {
            var _loc3_:Dictionary = var_1660[param1] as Dictionary;
            return null[param2] != null;
         }
         return false;
      }
      
      private function getBodyPartIDs(param1:String) : Array
      {
         var _loc4_:Dictionary = getBodyPartsOfType(param1);
         var _loc2_:Array = [];
         for(var _loc3_ in var_1660)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      private function getBodyPartsOfType(param1:String) : Dictionary
      {
         if(typeExists(param1))
         {
            return var_1660[param1] as Dictionary;
         }
         return new Dictionary();
      }
      
      public function getBodyPart(param1:String, param2:String) : GeometryBodyPart
      {
         var _loc3_:Dictionary = getBodyPartsOfType(param1);
         return _loc3_[param2];
      }
      
      public function getBodyPartOfItem(param1:String, param2:String, param3:class_1827) : GeometryBodyPart
      {
         var _loc4_:Dictionary = var_3718[param1];
         if(_loc4_ != null)
         {
            var _loc6_:GeometryBodyPart = _loc4_[param2];
            if(_loc6_ != null)
            {
               return null;
            }
            var _loc5_:Dictionary = getBodyPartsOfType(param1);
            for each(_loc6_ in null)
            {
               if(_loc6_.hasPart(param2,param3))
               {
                  return null;
               }
            }
         }
         return null;
      }
      
      private function getBodyPartsInAvatarSet(param1:Dictionary, param2:String) : Array
      {
         var _loc6_:GeometryBodyPart = null;
         var _loc4_:* = null;
         var _loc5_:Array = [];
         var _loc3_:Array = this.getBodyPartIdsInAvatarSet(param2);
         for each(_loc4_ in _loc3_)
         {
            _loc6_ = param1[_loc4_];
            if(_loc6_ != null)
            {
               _loc5_.push(_loc6_);
            }
         }
         return _loc5_;
      }
      
      public function getBodyPartsAtAngle(param1:String, param2:uint, param3:String) : Array
      {
         var _loc7_:Number = NaN;
         if(param3 == null)
         {
            class_21.log("[AvatarModelGeometry] ERROR: Geometry ID not found for action: ");
            return [];
         }
         var _loc4_:Dictionary = getBodyPartsOfType(param3);
         var _loc6_:Array = getBodyPartsInAvatarSet(_loc4_,param1);
         var_1590 = Matrix4x4.getYRotationMatrix(param2);
         for each(var _loc10_ in _loc6_)
         {
            _loc10_.applyTransform(var_1590);
            _loc7_ = Number(null.getDistance(_camera));
            _loc9_.push([_loc7_,null]);
         }
         _loc9_.sort(orderByDistance);
         for each(var _loc8_ in _loc9_)
         {
            _loc10_ = _loc8_[1] as GeometryBodyPart;
            _loc5_.push(null.id);
         }
         return _loc5_;
      }
      
      public function getParts(param1:String, param2:String, param3:uint, param4:Array, param5:class_1827) : Array
      {
         if(hasBodyPart(param1,param2))
         {
            var _loc6_:GeometryBodyPart = getBodyPartsOfType(param1)[param2] as GeometryBodyPart;
            var_1590 = Matrix4x4.getYRotationMatrix(param3);
            return null.getParts(var_1590,_camera,param4,param5);
         }
         return [];
      }
      
      private function orderByDistance(param1:Array, param2:Array) : Number
      {
         var _loc3_:Number = param1[0] as Number;
         var _loc4_:Number = param2[0] as Number;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return 0;
      }
   }
}

