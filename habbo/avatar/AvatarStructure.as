package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.avatar.actions.ActionDefinition;
   import com.sulake.habbo.avatar.actions.AvatarActionManager;
   import com.sulake.habbo.avatar.actions.class_2501;
   import com.sulake.habbo.avatar.actions.class_2768;
   import com.sulake.habbo.avatar.animation.AddDataContainer;
   import com.sulake.habbo.avatar.animation.Animation;
   import com.sulake.habbo.avatar.animation.AnimationLayerData;
   import com.sulake.habbo.avatar.animation.AnimationManager;
   import com.sulake.habbo.avatar.enum.AvatarDirectionAngle;
   import com.sulake.habbo.avatar.geometry.AvatarModelGeometry;
   import com.sulake.habbo.avatar.geometry.GeometryBodyPart;
   import com.sulake.habbo.avatar.geometry.GeometryItem;
   import com.sulake.habbo.avatar.structure.*;
   import com.sulake.habbo.avatar.structure.animation.AnimationAction;
   import com.sulake.habbo.avatar.structure.animation.AnimationActionPart;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.avatar.structure.figure.class_1932;
   import com.sulake.habbo.avatar.structure.figure.class_2017;
   import com.sulake.habbo.avatar.structure.figure.class_3134;
   import com.sulake.habbo.avatar.structure.parts.PartDefinition;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Stage;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   
   public class AvatarStructure extends EventDispatcherWrapper
   {
      
      private var var_645:class_49;
      
      private var _geometry:AvatarModelGeometry;
      
      private var var_754:AvatarActionManager;
      
      private var var_656:FigureSetData;
      
      private var var_787:PartSetsData;
      
      private var var_244:AnimationData;
      
      private var var_1294:AnimationManager;
      
      private var _defaultAction:ActionDefinition;
      
      private var var_1679:ActionDefinition;
      
      private var var_791:Dictionary;
      
      public function AvatarStructure(param1:class_49)
      {
         super();
         var_645 = param1;
         var_656 = new FigureSetData();
         var_787 = new PartSetsData();
         var_244 = new AnimationData();
         var_1294 = new AnimationManager();
         var_791 = new Dictionary();
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            super.dispose();
            var_645 = null;
            var_656 = null;
            var_787 = null;
            var_244 = null;
            var_791 = null;
         }
      }
      
      public function init() : void
      {
         var_791 = new Dictionary();
      }
      
      public function initGeometry(param1:XML) : void
      {
         if(!param1)
         {
            return;
         }
         _geometry = new AvatarModelGeometry(param1);
      }
      
      public function initActions(param1:class_40, param2:XML) : void
      {
         if(!param2)
         {
            return;
         }
         var_754 = new AvatarActionManager(param1,param2);
         _defaultAction = var_754.getDefaultAction();
         var_1679 = var_754.getDefaultLayAction();
      }
      
      public function updateActions(param1:XML) : void
      {
         var_754.updateActions(param1);
         _defaultAction = var_754.getDefaultAction();
         var_1679 = var_754.getDefaultLayAction();
      }
      
      public function initPartSets(param1:XML) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(var_787.parse(param1))
         {
            var_787.getPartDefinition("ri").appendToFigure = true;
            var_787.getPartDefinition("li").appendToFigure = true;
            return true;
         }
         return false;
      }
      
      public function initAnimation(param1:XML) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return var_244.parse(param1);
      }
      
      public function initFigureData(param1:XML) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return var_656.parse(param1);
      }
      
      public function injectFigureData(param1:XML) : void
      {
         var_656.injectXML(param1);
      }
      
      public function registerAnimations(param1:AssetLibraryCollection, param2:String = "fx", param3:int = 200) : void
      {
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < param3)
         {
            if(param1.hasAsset(param2 + _loc5_))
            {
               var _loc4_:XML = param1.getAssetByName(param2 + _loc5_).content as XML;
               var_1294.registerAnimation(this,null);
            }
            _loc5_++;
         }
      }
      
      public function registerAnimation(param1:XML) : void
      {
         var_1294.registerAnimation(this,param1);
      }
      
      public function getPartColor(param1:class_1900, param2:String, param3:int = 0) : IPartColor
      {
         var _loc4_:Array = param1.getPartColorIds(param2);
         if(!_loc4_ || _loc4_.length < param3)
         {
            return null;
         }
         var _loc6_:ISetType = var_656.getSetType(param2);
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc5_:class_2017 = var_656.getPalette(_loc6_.paletteID);
         if(!_loc5_)
         {
            return null;
         }
         return _loc5_.getColor(_loc4_[param3]);
      }
      
      public function getBodyPartData(param1:String, param2:int, param3:String) : AnimationLayerData
      {
         return var_1294.getLayerData(param1,param2,param3) as AnimationLayerData;
      }
      
      public function getAnimation(param1:String) : Animation
      {
         return var_1294.getAnimation(param1) as Animation;
      }
      
      public function getActionDefinition(param1:String) : ActionDefinition
      {
         return var_754.getActionDefinition(param1);
      }
      
      public function getDefaultActionDefinition() : ActionDefinition
      {
         return _defaultAction;
      }
      
      public function getDefaultLayActionDefinition() : ActionDefinition
      {
         return var_1679;
      }
      
      public function getActionDefinitionWithState(param1:String) : ActionDefinition
      {
         return var_754.getActionDefinitionWithState(param1);
      }
      
      public function isMainAvatarSet(param1:String) : Boolean
      {
         return _geometry.isMainAvatarSet(param1);
      }
      
      public function sortActions(param1:Array) : Array
      {
         return var_754.sortActions(param1);
      }
      
      public function maxFrames(param1:Array) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_ in param1)
         {
            _loc2_ = Math.max(_loc2_,var_244.getFrameCount(_loc3_.definition));
         }
         return _loc2_;
      }
      
      public function getMandatorySetTypeIds(param1:String, param2:int) : Array
      {
         if(!var_791[param1])
         {
            var_791[param1] = new Dictionary();
         }
         if(var_791[param1][param2])
         {
            return var_791[param1][param2];
         }
         var_791[param1][param2] = var_656.getMandatorySetTypeIds(param1,param2);
         return var_791[param1][param2];
      }
      
      public function getDefaultPartSet(param1:String, param2:String) : class_1932
      {
         return var_656.getDefaultPartSet(param1,param2);
      }
      
      public function getCanvasOffsets(param1:Array, param2:String, param3:int) : Array
      {
         return var_754.getCanvasOffsets(param1,param2,param3);
      }
      
      public function getCanvas(param1:String, param2:String) : AvatarCanvas
      {
         return _geometry.getCanvas(param1,param2);
      }
      
      public function removeDynamicItems(param1:class_1827) : void
      {
         _geometry.removeDynamicItems(param1);
      }
      
      public function getActiveBodyPartIds(param1:class_2501, param2:class_1827) : Array
      {
         var _loc7_:GeometryBodyPart = null;
         var _loc4_:String = null;
         var _loc8_:Animation = null;
         var _loc11_:Array = [];
         var _loc6_:Array = [];
         var _loc13_:String = param1.definition.geometryType;
         if(param1.definition.isAnimation)
         {
            _loc4_ = param1.definition.state + "." + param1.actionParameter;
            _loc8_ = var_1294.getAnimation(_loc4_) as Animation;
            if(_loc8_ != null)
            {
               _loc11_ = _loc8_.getAnimatedBodyPartIds(0,param1.overridingAction);
               if(_loc8_.hasAddData())
               {
                  var _loc12_:XML = <item id="" x="0" y="0" z="0" radius="0.01" nx="0" ny="0" nz="-1" double="1" />;
                  var _loc9_:XML = <part />;
                  for each(var _loc3_ in _loc8_.addData)
                  {
                     _loc7_ = _geometry.getBodyPart(_loc13_,_loc3_.align);
                     if(_loc7_ != null)
                     {
                        null.@id = _loc3_.id;
                        _loc7_.addPart(null,param2);
                        null["set-type"] = _loc3_.id;
                        var _loc14_:PartDefinition = var_787.addPartDefinition(null);
                        _loc14_.appendToFigure = true;
                        if(_loc3_.base == "")
                        {
                           null.staticId = 1;
                        }
                        if(_loc6_.indexOf(_loc7_.id) == -1)
                        {
                           _loc6_.push(_loc7_.id);
                        }
                     }
                  }
               }
            }
            for each(var _loc10_ in _loc11_)
            {
               _loc7_ = _geometry.getBodyPart(_loc13_,_loc10_);
               if(_loc7_ != null)
               {
                  if(_loc6_.indexOf(_loc7_.id) == -1)
                  {
                     _loc6_.push(_loc7_.id);
                  }
               }
            }
         }
         else
         {
            _loc11_ = var_787.getActiveParts(param1.definition);
            for each(var _loc5_ in _loc11_)
            {
               _loc7_ = _geometry.getBodyPartOfItem(_loc13_,_loc5_,param2);
               if(_loc7_ != null)
               {
                  if(_loc6_.indexOf(_loc7_.id) == -1)
                  {
                     _loc6_.push(_loc7_.id);
                  }
               }
            }
         }
         return _loc6_;
      }
      
      public function getBodyPartsUnordered(param1:String) : Array
      {
         return _geometry.getBodyPartIdsInAvatarSet(param1);
      }
      
      public function getBodyParts(param1:String, param2:String, param3:int) : Array
      {
         var _loc4_:Number = Number(AvatarDirectionAngle.const_50[param3]);
         return _geometry.getBodyPartsAtAngle(param1,_loc4_,param2);
      }
      
      public function getFrameBodyPartOffset(param1:class_2501, param2:int, param3:int, param4:String) : Point
      {
         var _loc5_:AnimationAction = var_244.getAction(param1.definition);
         if(_loc5_)
         {
            return _loc5_.getFrameBodyPartOffset(param2,param3,param4);
         }
         return AnimationAction.DEFAULT_OFFSET;
      }
      
      public function getParts(param1:String, param2:class_1900, param3:class_2501, param4:String, param5:int, param6:Array, param7:class_1827, param8:class_55 = null) : Vector.<AvatarImagePartContainer>
      {
         var _loc26_:* = null;
         var _loc28_:PartDefinition = null;
         var _loc41_:* = null;
         var _loc23_:AvatarImagePartContainer = null;
         var _loc21_:AnimationActionPart = null;
         var _loc45_:Array = null;
         var _loc48_:int = 0;
         var _loc15_:Array = null;
         var _loc36_:ISetType = null;
         var _loc24_:class_2017 = null;
         var _loc17_:class_1932 = null;
         var _loc18_:* = null;
         var _loc43_:class_2768 = null;
         var _loc34_:String = null;
         var _loc10_:IPartColor = null;
         var _loc29_:* = false;
         var _loc13_:* = null;
         var _loc19_:Boolean = false;
         var _loc39_:IPartColor = null;
         var _loc22_:Boolean = false;
         var _loc31_:String = null;
         var _loc44_:int = 0;
         var _loc32_:int = 0;
         var _loc25_:GeometryBodyPart = null;
         var _loc11_:Boolean = false;
         var _loc12_:Number = NaN;
         var _loc42_:String = null;
         if(param3 == null)
         {
            return null;
         }
         var _loc9_:Array = var_787.getActiveParts(param3.definition);
         var _loc46_:Array = [];
         var _loc35_:Array = [0];
         var _loc38_:AnimationAction = var_244.getAction(param3.definition);
         if(param3.definition.isAnimation)
         {
            var _loc27_:String = param3.definition.state + "." + param3.actionParameter;
            var _loc37_:Animation = var_1294.getAnimation(null) as Animation;
            if(_loc37_ != null)
            {
               _loc35_ = getPopulatedArray(null.frameCount(param3.overridingAction));
               for each(var _loc47_ in null.getAnimatedBodyPartIds(0,param3.overridingAction))
               {
                  if(_loc47_ == param1)
                  {
                     var _loc14_:GeometryBodyPart = _geometry.getBodyPart(param4,null);
                     if(_loc14_ != null)
                     {
                        for each(var _loc30_ in null.getDynamicParts(param7))
                        {
                           _loc9_.push(null.id);
                        }
                     }
                  }
               }
            }
         }
         var _loc20_:Array = _geometry.getParts(param4,param1,param5,_loc9_,param7);
         var _loc33_:Array = param2.getPartTypeIds();
         for each(_loc41_ in _loc33_)
         {
            if(param8 != null)
            {
               if(param8[_loc41_] != null)
               {
                  continue;
               }
            }
            _loc48_ = param2.getPartSetId(_loc41_);
            _loc15_ = param2.getPartColorIds(_loc41_);
            _loc36_ = var_656.getSetType(_loc41_);
            if(_loc36_)
            {
               _loc24_ = var_656.getPalette(_loc36_.paletteID);
               if(_loc24_)
               {
                  _loc17_ = _loc36_.getPartSet(_loc48_);
                  if(_loc17_)
                  {
                     param6 = param6.concat(_loc17_.hiddenLayers);
                     for each(_loc18_ in _loc17_.parts)
                     {
                        if(_loc20_.indexOf(_loc18_.type) > -1)
                        {
                           if(_loc38_ != null)
                           {
                              _loc21_ = _loc38_.getPart(_loc18_.type);
                              if(_loc21_ != null)
                              {
                                 _loc45_ = _loc21_.frames;
                              }
                              else
                              {
                                 _loc45_ = _loc35_;
                              }
                           }
                           else
                           {
                              _loc45_ = _loc35_;
                           }
                           _loc43_ = param3.definition;
                           if(_loc9_.indexOf(_loc18_.type) == -1)
                           {
                              _loc43_ = param3.definition.geometryType == "horizontal" ? var_1679 : _defaultAction;
                           }
                           _loc28_ = var_787.getPartDefinition(_loc18_.type);
                           _loc34_ = _loc28_ == null ? _loc18_.type : _loc28_.flippedSetType;
                           if(_loc34_ == "")
                           {
                              _loc34_ = _loc18_.type;
                           }
                           if(_loc15_ && _loc15_.length > _loc18_.colorLayerIndex - 1)
                           {
                              _loc10_ = _loc24_.getColor(_loc15_[_loc18_.colorLayerIndex - 1]);
                           }
                           _loc29_ = _loc18_.colorLayerIndex > 0;
                           _loc23_ = new AvatarImagePartContainer(param1,_loc18_.type,_loc18_.id.toString(),_loc10_,_loc45_,_loc43_,_loc29_,_loc18_.paletteMap,_loc34_);
                           _loc46_.push(_loc23_);
                        }
                     }
                  }
               }
            }
         }
         var _loc40_:Vector.<AvatarImagePartContainer> = new Vector.<AvatarImagePartContainer>();
         for each(_loc26_ in _loc20_)
         {
            _loc19_ = false;
            _loc39_ = null;
            _loc22_ = param8 && param8[_loc26_];
            for each(_loc13_ in _loc46_)
            {
               if(_loc13_.partType == _loc26_)
               {
                  if(_loc22_)
                  {
                     _loc39_ = _loc13_.color;
                  }
                  else
                  {
                     _loc19_ = true;
                     if(param6.indexOf(_loc26_) == -1)
                     {
                        _loc40_.push(_loc13_);
                     }
                  }
               }
            }
            if(!_loc19_)
            {
               if(_loc22_)
               {
                  _loc31_ = param8[_loc26_];
                  _loc44_ = 0;
                  _loc32_ = 0;
                  while(_loc32_ < _loc31_.length)
                  {
                     _loc44_ += _loc31_.charCodeAt(_loc32_);
                     _loc32_++;
                  }
                  if(_loc38_ != null)
                  {
                     _loc21_ = _loc38_.getPart(_loc26_);
                     if(_loc21_ != null)
                     {
                        _loc45_ = _loc21_.frames;
                     }
                     else
                     {
                        _loc45_ = _loc35_;
                     }
                  }
                  else
                  {
                     _loc45_ = _loc35_;
                  }
                  _loc23_ = new AvatarImagePartContainer(param1,_loc26_,_loc31_,_loc39_,_loc45_,param3.definition,_loc39_ != null,-1,_loc26_,false,1);
                  _loc40_.push(_loc23_);
               }
               else if(_loc9_.indexOf(_loc26_) > -1)
               {
                  _loc25_ = _geometry.getBodyPartOfItem(param4,_loc26_,param7);
                  if(param1 == _loc25_.id)
                  {
                     _loc28_ = var_787.getPartDefinition(_loc26_);
                     _loc11_ = false;
                     _loc12_ = 1;
                     if(_loc28_.appendToFigure)
                     {
                        _loc42_ = "1";
                        if(param3.actionParameter != "")
                        {
                           _loc42_ = param3.actionParameter;
                        }
                        if(_loc28_.hasStaticId())
                        {
                           _loc42_ = _loc28_.staticId.toString();
                        }
                        if(_loc38_ != null)
                        {
                           _loc21_ = _loc38_.getPart(_loc26_);
                           if(_loc21_ != null)
                           {
                              _loc45_ = _loc21_.frames;
                           }
                           else
                           {
                              _loc45_ = _loc35_;
                           }
                        }
                        else
                        {
                           _loc45_ = _loc35_;
                        }
                        _loc23_ = new AvatarImagePartContainer(param1,_loc26_,_loc42_,null,_loc45_,param3.definition,false,-1,_loc26_,_loc11_,_loc12_);
                        _loc40_.push(_loc23_);
                     }
                  }
               }
            }
         }
         return _loc40_;
      }
      
      public function get figureData() : class_1780
      {
         return var_656;
      }
      
      public function get animationManager() : AnimationManager
      {
         return var_1294;
      }
      
      public function get renderManager() : class_49
      {
         return var_645;
      }
      
      private function getPopulatedArray(param1:int) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_.push(_loc3_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function displayGeometry(param1:Stage) : void
      {
         var _loc7_:GeometryBodyPart = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc14_:Shape = null;
         var _loc4_:BitmapData = new BitmapData(960,540,false,4294967295);
         var _loc10_:Bitmap = new Bitmap(_loc4_);
         param1.addChild(_loc10_);
         var _loc3_:Number = _loc4_.width / 2;
         var _loc2_:Number = _loc4_.height / 2;
         var _loc13_:TextField = new TextField();
         var _loc6_:Matrix = new Matrix();
         for each(var _loc8_ in _geometry.getBodyPartIdsInAvatarSet("full"))
         {
            _loc7_ = _geometry.getBodyPart("vertical",_loc8_);
            class_21.log("Drawing bodypart : " + _loc8_);
            if(_loc7_ != null)
            {
               _loc11_ = _loc7_.location.x * 200;
               _loc12_ = _loc7_.location.z * 200;
               _loc9_ = _loc7_.radius * 200;
               _loc14_ = new Shape();
               _loc14_.graphics.lineStyle(1,4294901760,1);
               _loc14_.graphics.drawCircle(_loc3_ + _loc11_,_loc2_ + _loc12_,_loc9_);
               _loc4_.draw(_loc14_);
               _loc13_.text = _loc8_;
               _loc13_.textColor = 4294901760;
               _loc6_.identity();
               _loc6_.tx = _loc3_ + _loc11_ + _loc9_ - _loc13_.textWidth - 5;
               _loc6_.ty = _loc2_ + _loc12_ - 5;
               _loc4_.draw(_loc13_,_loc6_);
            }
            else
            {
               class_21.log("Could not draw bodypart : " + _loc8_);
            }
         }
      }
      
      public function getItemIds() : Array
      {
         var _loc2_:Dictionary = null;
         var _loc1_:Array = null;
         if(var_754)
         {
            _loc2_ = var_754.getActionDefinition("CarryItem").params;
            _loc1_ = [];
            for(var _loc3_ in _loc2_)
            {
               _loc1_.push(_loc3_);
            }
            return _loc1_;
         }
         return [];
      }
   }
}

