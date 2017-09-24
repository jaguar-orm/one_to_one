// GENERATED CODE - DO NOT MODIFY BY HAND

part of one_to_one;

// **************************************************************************
// Generator: BeanGenerator
// **************************************************************************

abstract class _UserBean implements Bean<User> {
  String get tableName => User.tableName;

  final StrField id = new StrField('id');

  final StrField name = new StrField('name');

  User fromMap(Map map) {
    User model = new User();

    model.id = map['id'];
    model.name = map['name'];

    return model;
  }

  List<SetColumn> toSetColumns(User model, [bool update = false]) {
    List<SetColumn> ret = [];

    ret.add(id.set(model.id));
    ret.add(name.set(model.name));

    return ret;
  }

  Future<Null> insert(User model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    await execInsert(insert);
    if (cascade) {
      User newModel;
      if (model.address != null) {
        newModel ??= await find(model.id);
        addressBean.associateUser(model.address, newModel);
        await addressBean.insert(model.address);
      }
    }
  }

  Future<int> update(User model,
      {bool cascade: false, bool associate: false}) async {
    final Update update =
        updater.where(this.id.eq(model.id)).setMany(toSetColumns(model));
    final ret = execUpdate(update);
    if (cascade) {
      User newModel;
      if (model.address != null) {
        if (associate) {
          newModel ??= await find(model.id);
          addressBean.associateUser(model.address, newModel);
        }
        await addressBean.update(model.address);
      }
    }
    return ret;
  }

  Future<User> find(String id,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final User model = await execFindOne(find);
    if (preload) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<List<User>> findWhere(Expression exp) async {
    final Find find = finder.where(exp);
    return await (await execFind(find)).toList();
  }

  Future<int> remove(String id, [bool cascade = false]) async {
    if (cascade) {
      final User newModel = await find(id);
      await addressBean.removeByUser(newModel.id);
    }
    final Remove remove = remover.where(this.id.eq(id));
    return execRemove(remove);
  }

  Future<int> removeMany(List<User> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return execRemove(remove);
  }

  Future<int> removeWhere(Expression exp) async {
    return execRemove(remover.where(exp));
  }

  Future preload(User model, {bool cascade: false}) async {
    model.address = await addressBean.findByUser(model.id,
        preload: cascade, cascade: cascade);
  }

  Future preloadAll(List<User> models, {bool cascade: false}) async {
    await PreloadHelper.preload<User, Address>(
        models,
        (User model) => [model.id],
        addressBean.findByUserList,
        (Address model) => [model.userid],
        (User model, Address child) => model.address = child,
        cascade: cascade);
  }

  AddressBean get addressBean;
}

abstract class _AddressBean implements Bean<Address> {
  String get tableName => Address.tableName;

  final StrField id = new StrField('id');

  final StrField userid = new StrField('userid');

  final StrField street = new StrField('street');

  Address fromMap(Map map) {
    Address model = new Address();

    model.id = map['id'];
    model.userid = map['userid'];
    model.street = map['street'];

    return model;
  }

  List<SetColumn> toSetColumns(Address model, [bool update = false]) {
    List<SetColumn> ret = [];

    ret.add(id.set(model.id));
    ret.add(userid.set(model.userid));
    ret.add(street.set(model.street));

    return ret;
  }

  Future<dynamic> insert(Address model) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    return execInsert(insert);
  }

  Future<int> update(Address model) async {
    final Update update =
        updater.where(this.id.eq(model.id)).setMany(toSetColumns(model));
    return execUpdate(update);
  }

  Future<Address> find(String id,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await execFindOne(find);
  }

  Future<List<Address>> findWhere(Expression exp) async {
    final Find find = finder.where(exp);
    return await (await execFind(find)).toList();
  }

  Future<int> remove(String id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return execRemove(remove);
  }

  Future<int> removeMany(List<Address> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return execRemove(remove);
  }

  Future<int> removeWhere(Expression exp) async {
    return execRemove(remover.where(exp));
  }

  Future<Address> findByUser(String userid,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.userid.eq(userid));
    return await execFindOne(find);
  }

  Future<int> removeByUser(String userid) async {
    final Remove rm = remover.where(this.userid.eq(userid));
    return await execRemove(rm);
  }

  Future<List<Address>> findByUserList(List<User> models,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder;
    for (User model in models) {
      find.or(this.userid.eq(model.id));
    }
    return await (await execFind(find)).toList();
  }

  void associateUser(Address child, User parent) {
    child.userid = parent.id;
  }
}
