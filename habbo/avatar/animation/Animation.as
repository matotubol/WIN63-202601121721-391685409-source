package com.sulake.habbo.avatar.animation
{
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.avatar.AvatarStructure;
   import com.sulake.habbo.avatar.actions.class_2768;
   
   public class Animation implements class_2608
   {
      
      private static const const_29:Array = [];
      
      private var var_197:String;
      
      private var var_735:String;
      
      private var var_353:Array = [];
      
      private var var_3510:Vector.<ISpriteDataContainer>;
      
      private var var_3554:AvatarDataContainer;
      
      private var var_3560:DirectionDataContainer;
      
      private var var_2804:Array;
      
      private var var_1042:Array;
      
      private var _overriddenActions:class_55;
      
      private var _overrideFrames:class_55;
      
      private var var_2702:Boolean;
      
      public function Animation(param1:AvatarStructure, param2:XML)
      {
         super();
         var_197 = String(param2.@name);
         if(param2.hasOwnProperty("@desc"))
         {
            var_735 = String(param2.@desc);
         }
         else
         {
            var_735 = var_197;
         }
         if(param2.hasOwnProperty("@resetOnToggle"))
         {
            var_2702 = Boolean(param2.@resetOnToggle);
         }
         else
         {
            var_2702 = false;
         }
         if(param2.hasOwnProperty("sprite"))
         {
            var_3510 = new Vector.<ISpriteDataContainer>();
            for each(var _loc6_ in param2.sprite)
            {
               var_3510.push(new SpriteDataContainer(this as class_2608,_loc6_));
            }
         }
         if(param2.hasOwnProperty("avatar"))
         {
            var_3554 = new AvatarDataContainer(param2.avatar[0]);
         }
         if(param2.hasOwnProperty("direction"))
         {
            var_3560 = new DirectionDataContainer(param2.direction[0]);
         }
         if(param2.hasOwnProperty("remove"))
         {
            var_2804 = [];
            for each(var _loc8_ in param2.remove)
            {
               var_2804.push(String(_loc8_.@id));
            }
         }
         if(param2.hasOwnProperty("add"))
         {
            var_1042 = [];
            for each(var _loc9_ in param2.add)
            {
               var_1042.push(new AddDataContainer(_loc9_));
            }
         }
         if(param2.hasOwnProperty("override"))
         {
            _overrideFrames = new class_55();
            _overriddenActions = new class_55();
            for each(var _loc4_ in param2.name_8)
            {
               var _loc5_:String = _loc4_.@name;
               var _loc7_:String = _loc4_.@name_8;
               _overriddenActions.add(null,null);
               var _loc3_:Array = [];
               parseFrames(null,_loc4_.frame,param1);
               _overrideFrames.add(null,null);
            }
         }
         parseFrames(var_353,param2.frame,param1);
      }
      
      private function parseFrames(param1:Array, param2:XMLList, param3:AvatarStructure) : void
      {
         var _loc5_:Array = null;
         var _loc10_:class_2768 = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc12_:AnimationLayerData = null;
         var _loc8_:AnimationLayerData = null;
         for each(var _loc11_ in param2)
         {
            _loc6_ = 1;
            if(_loc11_.@repeats > 1)
            {
               _loc6_ = int(_loc11_.@repeats);
            }
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc5_ = [];
               for each(var _loc9_ in _loc11_.bodypart)
               {
                  _loc10_ = param3.getActionDefinition(String(_loc9_.@action));
                  _loc12_ = new AnimationLayerData(_loc9_,"bodypart",_loc10_);
                  _loc5_.push(_loc12_);
               }
               for each(var _loc7_ in _loc11_.fx)
               {
                  _loc10_ = param3.getActionDefinition(String(_loc7_.@action));
                  _loc8_ = new AnimationLayerData(_loc7_,"fx",_loc10_);
                  _loc5_.push(_loc8_);
                  if(_loc10_ != null)
                  {
                  }
               }
               param1.push(_loc5_);
               _loc4_++;
            }
         }
      }
      
      public function frameCount(param1:String = null) : int
      {
         if(!param1)
         {
            return var_353.length;
         }
         if(_overrideFrames)
         {
            var _loc2_:Array = _overrideFrames.getValue(param1);
         }
         return 0;
      }
      
      public function hasOverriddenActions() : Boolean
      {
         if(!_overriddenActions)
         {
            return false;
         }
         return _overriddenActions.length > 0;
      }
      
      public function overriddenActionNames() : Array
      {
         if(!_overriddenActions)
         {
            return null;
         }
         return _overriddenActions.getKeys();
      }
      
      public function overridingAction(param1:String) : String
      {
         if(!_overriddenActions)
         {
            return null;
         }
         return _overriddenActions.getValue(param1);
      }
      
      private function getFrame(param1:int, param2:String = null) : Array
      {
         var _loc3_:Array = null;
         var _loc4_:Array = [];
         if(!param2)
         {
            if(var_353.length > 0)
            {
               _loc4_ = var_353[param1 % var_353.length];
            }
         }
         else
         {
            _loc3_ = _overrideFrames.getValue(param2) as Array;
            if(_loc3_ && _loc3_.length > 0)
            {
               _loc4_ = _loc3_[param1 % _loc3_.length];
            }
         }
         return _loc4_;
      }
      
      public function getAnimatedBodyPartIds(param1:int, param2:String = null) : Array
      {
         var _loc4_:Array = [];
         for each(var _loc3_ in getFrame(param1,param2))
         {
            if(_loc3_.type == "bodypart")
            {
               _loc4_.push(_loc3_.id);
            }
            else if(_loc3_.type == "fx")
            {
               if(var_1042)
               {
                  for each(var _loc5_ in var_1042)
                  {
                     if(_loc5_.id == _loc3_.id)
                     {
                        _loc4_.push(_loc5_.align);
                     }
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function getLayerData(param1:int, param2:String, param3:String = null) : AnimationLayerData
      {
         for each(var _loc4_ in getFrame(param1,param3))
         {
            if(_loc4_.id == param2)
            {
               return _loc4_ as AnimationLayerData;
            }
            if(_loc4_.type == "fx")
            {
               for each(var _loc5_ in var_1042)
               {
                  if(_loc5_.align == param2 && _loc5_.id == _loc4_.id)
                  {
                     return _loc4_ as AnimationLayerData;
                  }
               }
            }
         }
         return null;
      }
      
      public function hasAvatarData() : Boolean
      {
         return var_3554 != null;
      }
      
      public function hasDirectionData() : Boolean
      {
         return var_3560 != null;
      }
      
      public function hasAddData() : Boolean
      {
         return var_1042 != null;
      }
      
      public function getAddData(param1:String) : AddDataContainer
      {
         if(var_1042)
         {
            for each(var _loc2_ in var_1042)
            {
               if(_loc2_.id == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function get id() : String
      {
         return var_197;
      }
      
      public function get spriteData() : Vector.<ISpriteDataContainer>
      {
         return var_3510;
      }
      
      public function get avatarData() : AvatarDataContainer
      {
         return var_3554;
      }
      
      public function get directionData() : DirectionDataContainer
      {
         return var_3560;
      }
      
      public function get removeData() : Array
      {
         return var_2804 ? var_2804 : const_29;
      }
      
      public function get addData() : Array
      {
         return var_1042 ? var_1042 : const_29;
      }
      
      public function toString() : String
      {
         return var_735;
      }
      
      public function get resetOnToggle() : Boolean
      {
         return var_2702;
      }
   }
}

