package com.sulake.habbo.room.utils
{
   import com.sulake.core.class_23;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.room.class_34;
   import com.sulake.habbo.room.object.visualization.room.PlaneDrawingData;
   import com.sulake.room.data.RoomObjectSpriteData;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
   import com.sulake.room.object.visualization.IRoomPlane;
   import com.sulake.room.object.visualization.ISortableSprite;
   import com.sulake.room.object.visualization.class_2075;
   import com.sulake.room.object.visualization.class_2507;
   import com.sulake.room.object.visualization.utils.class_1805;
   import com.sulake.room.renderer.IRoomRenderingCanvas;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.Vector3d;
   import flash.display.Stage;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   [SecureSWF(rename="true")]
   public class class_2200
   {
      
      private static const MANNEQUIN_MAGIC_X_OFFSET:int = 1;
      
      private static const MANNEQUIN_MAGIC_Y_OFFSET:int = -16;
      
      private static const AVATAR_WATER_EFFECT_MAGIC_Y_OFFSET:int = -52;
      
      private static const MAX_EXTERNAL_IMAGE_COUNT:int = 30;
      
      private var var_1332:Number;
      
      private var spriteCount:int = 0;
      
      private var externalImageCount:int = 0;
      
      public function class_2200()
      {
         super();
      }
      
      private static function addMannequinSprites(param1:Vector.<RoomObjectSpriteData>, param2:class_34) : Vector.<RoomObjectSpriteData>
      {
         var _loc7_:IRoomObject = null;
         var _loc6_:Array = null;
         var _loc3_:Vector.<RoomObjectSpriteData> = new Vector.<RoomObjectSpriteData>();
         for each(var _loc5_ in param1)
         {
            if(_loc5_.objectType == "boutique_mannequin1" && _loc5_.name.indexOf("mannequin_") == 0)
            {
               _loc7_ = param2.getRoomObject(param2.activeRoomId,_loc5_.objectId,10);
               if(_loc7_ != null)
               {
                  _loc6_ = IRoomObjectSpriteVisualization(_loc7_.getVisualization()).getSpriteList();
                  if(_loc6_ != null)
                  {
                     for each(var _loc4_ in _loc6_)
                     {
                        _loc4_.x += _loc5_.x + _loc5_.width / 2 + 1;
                        _loc4_.y += _loc5_.y + _loc5_.height + -16;
                        _loc4_.z += _loc5_.z;
                        _loc3_.push(_loc4_);
                     }
                  }
               }
            }
            else
            {
               _loc3_.push(_loc5_);
            }
         }
         return _loc3_;
      }
      
      private static function sortSpriteDataObjects(param1:RoomObjectSpriteData, param2:RoomObjectSpriteData) : Number
      {
         if(param1.z < param2.z)
         {
            return 1;
         }
         if(param1.z > param2.z)
         {
            return -1;
         }
         return -1;
      }
      
      private static function isSpriteInViewPort(param1:RoomObjectSpriteData, param2:Rectangle, param3:IRoomRenderingCanvas) : Boolean
      {
         var _loc4_:Rectangle = new Rectangle(param1.x + param3.screenOffsetX,param1.y + param3.screenOffsetY,param1.width,param1.height);
         return _loc4_.intersects(param2);
      }
      
      private static function sortQuadPoints(param1:Point, param2:Point, param3:Point, param4:Point) : Vector.<Point>
      {
         var _loc5_:Point = null;
         var _loc6_:Vector.<Point> = new Vector.<Point>(0);
         if(param1.x == param2.x)
         {
            _loc6_.push(param1,param3,param2,param4);
         }
         else if(param1.x == param3.x)
         {
            _loc6_.push(param1,param2,param3,param4);
         }
         else if(param2.x < param1.x && param2.y > param1.y || param2.x > param1.x && param2.y < param1.y)
         {
            _loc6_.push(param1,param3,param2,param4);
         }
         else
         {
            _loc6_.push(param1,param2,param3,param4);
         }
         if(_loc6_[0].x < _loc6_[1].x)
         {
            _loc5_ = _loc6_[0];
            _loc6_[0] = _loc6_[1];
            _loc6_[1] = _loc5_;
            _loc5_ = _loc6_[2];
            _loc6_[2] = _loc6_[3];
            _loc6_[3] = _loc5_;
         }
         if(_loc6_[0].y < _loc6_[2].y)
         {
            _loc5_ = _loc6_[0];
            _loc6_[0] = _loc6_[2];
            _loc6_[2] = _loc5_;
            _loc5_ = _loc6_[1];
            _loc6_[1] = _loc6_[3];
            _loc6_[3] = _loc5_;
         }
         return _loc6_;
      }
      
      public function getFurniData(param1:Rectangle, param2:IRoomRenderingCanvas, param3:class_34, param4:int) : String
      {
         var _loc12_:Array = null;
         var _loc7_:Number = NaN;
         var _loc16_:int = 0;
         var _loc13_:Point = null;
         var _loc8_:Vector.<Object> = new Vector.<Object>();
         var _loc6_:Vector.<RoomObjectSpriteData> = param2.getSortableSpriteList();
         var _loc11_:Array = param3.getRoomObjects(param3.activeRoomId,100);
         for each(var _loc10_ in _loc11_)
         {
            if(_loc10_.getId() != param4)
            {
               _loc12_ = IRoomObjectSpriteVisualization(_loc10_.getVisualization()).getSpriteList();
               if(_loc12_)
               {
                  _loc7_ = 0;
                  _loc16_ = 0;
                  for each(var _loc14_ in _loc6_)
                  {
                     if(_loc14_.name == "avatar_" + _loc10_.getId())
                     {
                        _loc7_ = _loc14_.z;
                        _loc16_ = _loc14_.y + _loc14_.height - param2.geometry.scale / 4;
                        break;
                     }
                  }
                  _loc13_ = param3.getRoomObjectScreenLocation(param3.activeRoomId,_loc10_.getId(),100,param2.getId());
                  if(_loc13_)
                  {
                     if(_loc16_ == 0)
                     {
                        _loc16_ = _loc13_.y;
                     }
                     for each(var _loc15_ in _loc12_)
                     {
                        _loc15_.x += _loc13_.x - param2.screenOffsetX;
                        _loc15_.y += _loc16_;
                        _loc15_.z += _loc7_;
                        if(_loc15_.name.indexOf("h_std_fx29_") == 0 || _loc15_.name.indexOf("h_std_fx185_") == 0)
                        {
                           _loc15_.y += -52;
                        }
                        _loc6_.push(_loc15_);
                     }
                  }
               }
            }
         }
         _loc6_ = addMannequinSprites(_loc6_,param3);
         _loc6_.sort(sortSpriteDataObjects);
         for each(var _loc5_ in _loc6_)
         {
            if(_loc5_.name != null && _loc5_.name.length > 0 && _loc5_.name.indexOf("tile_cursor_") != 0 && isSpriteInViewPort(_loc5_,param1,param2) && (param4 < 0 || _loc5_.objectId != param4))
            {
               _loc8_.push(getSpriteDataObject(_loc5_,param1,param2,param3));
               if(!var_1332)
               {
                  var_1332 = _loc5_.z;
               }
               spriteCount = spriteCount + 1;
            }
         }
         return JSON.stringify(_loc8_);
      }
      
      public function getRoomRenderingModifiers(param1:class_34) : String
      {
         var _loc2_:Object = {};
         return JSON.stringify(_loc2_);
      }
      
      private function getSpriteDataObject(param1:RoomObjectSpriteData, param2:Rectangle, param3:IRoomRenderingCanvas, param4:class_34) : Object
      {
         var _loc10_:String = null;
         var _loc13_:Array = null;
         var _loc6_:class_1805 = null;
         var _loc11_:XML = null;
         var _loc9_:String = null;
         var _loc8_:String = null;
         var _loc5_:Object = {};
         var _loc12_:* = param1.name;
         if(param1.name.indexOf("@") != -1)
         {
            _loc13_ = param1.name.split("@");
            _loc12_ = _loc13_[0];
            _loc10_ = _loc13_[1];
         }
         if(_loc10_ && param1.objectType)
         {
            _loc6_ = param4.roomContentLoader.getGraphicAssetCollection(param1.objectType);
            if(_loc6_ != null)
            {
               _loc11_ = _loc6_.getPaletteXML(_loc10_);
               if(_loc11_ != null && _loc11_.@source != null)
               {
                  _loc5_.paletteSourceName = _loc11_.@source + "";
               }
            }
         }
         var _loc7_:String = param4.configuration.getProperty("image.library.url");
         _loc12_ = _loc12_.replace("%image.library.url%",_loc7_);
         if(_loc12_.indexOf("%group.badge.url%") != -1)
         {
            _loc9_ = param4.configuration.getProperty("group.badge.url");
            _loc12_ = _loc12_.replace("%group.badge.url%","");
            _loc12_ = _loc8_ = _loc9_.replace("%imagerdata%",_loc12_);
         }
         _loc5_.name = _loc12_;
         _loc5_.x = param1.x - param2.x;
         _loc5_.y = param1.y - param2.y;
         _loc5_.x += param3.screenOffsetX;
         _loc5_.y += param3.screenOffsetY;
         _loc5_.z = param1.z;
         if(param1.alpha && param1.alpha.toString() != "255")
         {
            _loc5_.alpha = param1.alpha;
         }
         if(param1.flipH)
         {
            _loc5_.flipH = param1.flipH;
         }
         if(param1.skew)
         {
            _loc5_.skew = param1.skew;
         }
         if(param1.frame)
         {
            _loc5_.frame = param1.frame;
         }
         if(param1.color && param1.color.length > 0)
         {
            _loc5_.color = int(param1.color);
         }
         if(param1.blendMode && param1.blendMode != "normal")
         {
            _loc5_.blendMode = param1.blendMode;
         }
         if(_loc12_.indexOf("http") == 0)
         {
            _loc5_.width = param1.width;
            _loc5_.height = param1.height;
            externalImageCount = externalImageCount + 1;
            if(externalImageCount > 30)
            {
               _loc5_.name = "box";
            }
         }
         if(param1.posture)
         {
            _loc5_.posture = param1.posture;
         }
         return _loc5_;
      }
      
      private function makeBackgroundPlane(param1:Rectangle, param2:uint, param3:Array) : class_2507
      {
         var _loc4_:Number = NaN;
         var _loc6_:Point = new Point(0,0);
         var _loc7_:Point = new Point(param1.width,0);
         var _loc8_:Point = new Point(0,param1.height);
         var _loc10_:Point = new Point(param1.width,param1.height);
         var _loc9_:Vector.<Point> = sortQuadPoints(_loc6_,_loc7_,_loc8_,_loc10_);
         if(param3.length > 0)
         {
            _loc4_ = Number(param3[0].z);
            if(var_1332)
            {
               _loc4_ = Math.max(var_1332,_loc4_);
            }
         }
         else
         {
            _loc4_ = var_1332 ? var_1332 : 0;
         }
         _loc4_ += spriteCount * 1.776104 + param3.length * 2.31743;
         var _loc5_:class_2507 = new PlaneDrawingData(null,param2);
         _loc5_.cornerPoints = _loc9_;
         _loc5_.z = _loc4_;
         return _loc5_;
      }
      
      private function sortRoomPlanes(param1:Vector.<IRoomPlane>, param2:IRoomRenderingCanvas, param3:class_34) : Array
      {
         var _loc6_:Object = null;
         var _loc7_:IRoomObjectSprite = null;
         var _loc9_:class_55 = new class_55();
         var _loc10_:Number = 1;
         if(var_1332)
         {
            _loc10_ += var_1332;
         }
         for each(var _loc4_ in param1)
         {
            _loc6_ = {};
            _loc6_.plane = _loc4_;
            _loc6_.z = _loc10_;
            _loc9_.add(_loc4_.uniqueId,_loc6_);
         }
         var _loc11_:Array = param2.getPlaneSortableSprites();
         _loc11_.sortOn("z",16);
         _loc11_.reverse();
         var _loc5_:Array = [];
         for each(var _loc8_ in _loc11_)
         {
            _loc7_ = _loc8_.sprite;
            if(_loc7_ != null)
            {
               _loc6_ = _loc9_.remove(_loc7_.planeId);
               if(_loc6_ != null)
               {
                  _loc6_.z = _loc8_.z;
                  _loc5_.push(_loc6_);
               }
            }
         }
         return _loc5_.concat(_loc9_.getValues());
      }
      
      public function getRoomPlanes(param1:Rectangle, param2:IRoomRenderingCanvas, param3:class_34, param4:uint) : Array
      {
         var _loc20_:IRoomGeometry = null;
         var _loc12_:Array = null;
         var _loc17_:Stage = null;
         var _loc5_:IRoomPlane = null;
         var _loc15_:* = undefined;
         var _loc14_:Vector3d = null;
         var _loc6_:Point = null;
         var _loc8_:Point = null;
         var _loc9_:Point = null;
         var _loc11_:Point = null;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc19_:* = undefined;
         var _loc10_:Array = [];
         var _loc18_:IRoomObject = param3.getRoomObject(param3.activeRoomId,-1,0);
         var _loc7_:class_2075 = _loc18_.getVisualization() as class_2075;
         if(_loc7_)
         {
            _loc20_ = param2.geometry;
            _loc12_ = sortRoomPlanes(_loc7_.planes,param2,param3);
            _loc17_ = class_23.instance.displayObjectContainer.stage;
            for each(var _loc16_ in _loc12_)
            {
               _loc5_ = _loc16_.plane;
               _loc15_ = new Vector.<Point>(0);
               _loc14_ = Vector3d.sum(_loc5_.location,_loc5_.leftSide);
               _loc6_ = _loc20_.getScreenPoint(_loc5_.location);
               _loc8_ = _loc20_.getScreenPoint(_loc14_);
               _loc9_ = _loc20_.getScreenPoint(Vector3d.sum(_loc5_.location,_loc5_.rightSide));
               _loc11_ = _loc20_.getScreenPoint(Vector3d.sum(_loc14_,_loc5_.rightSide));
               _loc15_.push(_loc6_,_loc8_,_loc9_,_loc11_);
               _loc22_ = 0;
               _loc23_ = 0;
               for each(var _loc13_ in _loc15_)
               {
                  _loc13_.offset(_loc17_.stageWidth / 2,_loc17_.stageHeight / 2);
                  _loc13_.offset(param2.screenOffsetX,param2.screenOffsetY);
                  _loc13_.offset(-param1.x,-param1.y);
                  if(_loc13_.x < 0)
                  {
                     _loc22_--;
                  }
                  else if(_loc13_.x >= param1.width)
                  {
                     _loc22_++;
                  }
                  if(_loc13_.y < 0)
                  {
                     _loc23_--;
                  }
                  else if(_loc13_.y >= param1.height)
                  {
                     _loc23_++;
                  }
               }
               if(!(Math.abs(_loc22_) == 4 || Math.abs(_loc23_) == 4))
               {
                  _loc19_ = sortQuadPoints(_loc6_,_loc8_,_loc9_,_loc11_);
                  for each(var _loc21_ in _loc5_.getDrawingDatas(_loc20_))
                  {
                     _loc21_.cornerPoints = _loc19_;
                     _loc21_.z = _loc16_.z;
                     _loc10_.push(_loc21_);
                  }
               }
            }
            _loc10_.unshift(makeBackgroundPlane(param1,param4,_loc10_));
         }
         return _loc10_;
      }
   }
}

