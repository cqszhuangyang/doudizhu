#include "LuaEngine.h"
#include "CCLuaEngine.h"
#include "cocos2d.h"
#include<string>
USING_NS_CC;
using namespace std;

LuaEngine::LuaEngine()
{
}


LuaEngine::~LuaEngine()
{
	if (m_luaState)
	{
		lua_close(m_luaState);
		m_luaState = NULL;
	}
	
}

void LuaEngine::init()
{
	m_luaState = luaL_newstate();
	luaL_openlibs(m_luaState);
	
	
}
void LuaEngine::readVariable()
{

	string path = CCFileUtils::sharedFileUtils()->fullPathForFilename("luaCTest.lua");
	luaL_dofile(m_luaState, path.c_str());
	lua_settop(m_luaState, 0);
	lua_getglobal(m_luaState, "name");
	const char* c = lua_tostring(m_luaState, -1);
	CCLOG("name is %s", c);
}
void LuaEngine::callFunction()
{
	string path = CCFileUtils::sharedFileUtils()->fullPathForFilename("luaCTest.lua");
	luaL_dofile(m_luaState, path.c_str());
	lua_settop(m_luaState, 0);
	lua_getglobal(m_luaState, "getResult");
	string  params = "dsd=====";
	lua_pushstring(m_luaState, params.c_str());
	lua_pcall(m_luaState, 1, 1, 0);
	const char* c = lua_tostring(m_luaState, -1);
	CCLOG("name is %s", c);
}
LuaEngine* LuaEngine::instance = NULL;
LuaEngine* LuaEngine::shareLuaEngine()
{
	if (instance == NULL)
	{
		instance = new LuaEngine();
	}
	return instance;
}

