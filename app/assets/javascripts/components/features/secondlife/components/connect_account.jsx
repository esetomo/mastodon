const ConnectAccount = React.createClass({
  render() {
	  const { account } = this.props;
	
	  if (!account) {
	    return <div />;
	  }

    const sl_user_name = account.get('sl_user_name');
    var connectLink;
    if (sl_user_name !== null) {
      const sl_url = 'https://my.secondlife.com/' + sl_user_name;
      connectLink =
        (
          <a
            href={sl_url}
            target="_blank"
            rel="noopener"
          >
            <span className="sl-connect-account__label">
              SecondLifeアカウントと連携済み
            </span>
          </a>
        );
    } else {
      connectLink =
        (
          <a
            className="sl-connect-account__wrapper"
            href="/auth/auth/secondlife"
          >
            <span className="sl-connect-account__label sl-connect-account__label--disabled">
              SecondLifeアカウントと連携する
            </span>
          </a>
        );
    }

    return (
      <div className="sl-connect-account">
        {connectLink}
      </div>
	  );
  }
});

export default ConnectAccount;
