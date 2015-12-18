import sqlalchemy as sa
from ringo.model import Base
from ringo.model.base import BaseItem, BaseFactory
from ringo.model.base import BaseItem


nm_news_user = sa.Table(
    'nm_news_user', Base.metadata,
    sa.Column('id', sa.Integer, primary_key=True),
    sa.Column('uid', sa.Integer, sa.ForeignKey('users.id')),
    sa.Column('nid', sa.Integer, sa.ForeignKey('news.id'))
)
"""Table to store the unread (visible) news for a user. If the user has read
the news the entry in this table can be removed"""


class NewsFactory(BaseFactory):

    def create(self, user=None):
        new_item = BaseFactory.create(self, user)
        return new_item


class News(BaseItem, Base):
    """Docstring for news extension"""

    __tablename__ = 'news'
    """Name of the table in the database for this modul. Do not
    change!"""
    _modul_id = None
    """Will be set dynamically. See include me of this modul"""

    # Define columns of the table in the database
    id = sa.Column(sa.Integer, primary_key=True)

    # Define relations to other tables
    subject = sa.Column(sa.String)
    text = sa.Column(sa.Text)

    users = sa.orm.relationship("User",
                                secondary=nm_news_user,
                                backref='news')

    @classmethod
    def get_item_factory(cls):
        return NewsFactory(cls)
